import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tp_gilberto_pires/core/models/post.dart';
import 'package:tp_gilberto_pires/core/blocs/post_bloc.dart';
import 'package:tp_gilberto_pires/core/blocs/post_event.dart';
import 'package:tp_gilberto_pires/core/blocs/post_state.dart';

class PostDetailPage extends StatefulWidget {
  final String postId;

  const PostDetailPage({super.key, required this.postId});

  @override
  State<PostDetailPage> createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  bool _loading = true;
  Post? _post;

  @override
  void initState() {
    super.initState();
    _fetchPost();
  }

  Future<void> _fetchPost() async {
    final doc =
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(widget.postId)
            .get();

    final data = doc.data();
    if (data != null) {
      _post = Post.fromJson(doc.id, data);
      _titleController = TextEditingController(text: _post!.title);
      _descriptionController = TextEditingController(text: _post!.description);
      setState(() => _loading = false);
    }
  }

  void _submit() {
    if (_formKey.currentState!.validate() && _post != null) {
      final updatedPost = _post!.copyWith(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        lastUpdatedAt: DateTime.now(),
      );

      context.read<PostBloc>().add(PostUpdated(updatedPost));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return BlocListener<PostBloc, PostState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        if (state.status == PostStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Post mis à jour avec succès')),
          );
          context.go('/');
        } else if (state.status == PostStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erreur : ${state.errorMessage}')),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Modifier le post')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Titre'),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Entrez un titre'
                              : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                  maxLines: 3,
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Entrez une description'
                              : null,
                ),
                const Spacer(),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: _submit,
                      child: const Text('Enregistrer les modifications'),
                    ),
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: () => context.go('/'),
                      child: const Text('Annuler et revenir à la liste'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
