import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tp_gilberto_pires/core/models/post.dart';
import 'package:tp_gilberto_pires/features/post/blocs/post_bloc.dart';
import 'package:tp_gilberto_pires/features/post/blocs/post_event.dart';
import 'package:tp_gilberto_pires/features/post/blocs/post_state.dart';

class PostFormPage extends StatefulWidget {
  const PostFormPage({super.key});

  @override
  State<PostFormPage> createState() => _PostFormPageState();
}

class _PostFormPageState extends State<PostFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final newPost = Post(
        title: _titleController.text.trim(),
        description: _descriptionController.text.trim(),
        lastUpdatedAt: DateTime.now(),
      );

      context.read<PostBloc>().add(PostCreated(newPost));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PostBloc, PostState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == PostStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Post créé avec succès')),
          );
          context.go('/');
        } else if (state.status == PostStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erreur : ${state.errorMessage}')),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Créer un post')),
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
                      child: const Text('Créer'),
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
