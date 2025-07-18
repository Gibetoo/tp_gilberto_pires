import 'package:tp_gilberto_pires/core/models/post.dart';

enum PostStatus { initial, loading, success, failure, empty }

class PostState {
  final PostStatus status;
  final List<Post> posts;
  final String? errorMessage;

  const PostState({
    this.status = PostStatus.initial,
    this.posts = const [],
    this.errorMessage,
  });

  PostState copyWith({
    PostStatus? status,
    List<Post>? posts,
    String? errorMessage,
  }) {
    return PostState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
