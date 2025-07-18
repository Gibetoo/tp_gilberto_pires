import 'package:tp_gilberto_pires/core/models/post.dart';
import 'posts_data_source.dart';

class PostsRepository {
  final PostsDataSource dataSource;

  PostsRepository(this.dataSource);

  Future<List<Post>> getPosts() => dataSource.getPosts();

  Future<void> createPost(Post post) => dataSource.createPost(post);

  Future<void> updatePost(Post post) => dataSource.updatePost(post);
}
