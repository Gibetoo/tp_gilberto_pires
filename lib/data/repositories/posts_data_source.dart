import 'package:tp_gilberto_pires/core/models/post.dart';

abstract class PostsDataSource {
  Future<List<Post>> getPosts();
  Future<void> createPost(Post post);
  Future<void> updatePost(Post post);
}
