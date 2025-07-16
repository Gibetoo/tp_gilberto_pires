import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tp_gilberto_pires/features/post/blocs/post_bloc.dart';
import 'package:tp_gilberto_pires/features/post/blocs/post_state.dart';

class PostListPage extends StatelessWidget {
  const PostListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Liste des Posts')),
      body: BlocBuilder<PostBloc, PostState>(
        builder: (context, state) {
          switch (state.status) {
            case PostStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case PostStatus.failure:
              return Center(child: Text('Erreur : ${state.errorMessage}'));
            case PostStatus.empty:
              return const Center(child: Text('Aucun post disponible.'));
            case PostStatus.success:
              return ListView.builder(
                itemCount: state.posts.length,
                itemBuilder: (context, index) {
                  final post = state.posts[index];
                  return ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.description),
                    trailing:
                        post.lastUpdatedAt != null
                            ? Text(
                              '${post.lastUpdatedAt!.toLocal()}'.split('.')[0],
                              style: const TextStyle(fontSize: 12),
                            )
                            : null,
                    onTap: () {
                      if (post.id != null) {
                        context.go('/post/${post.id}');
                      }
                    },
                  );
                },
              );
            default:
              return const SizedBox.shrink();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/create');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
