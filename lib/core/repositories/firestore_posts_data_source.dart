import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tp_gilberto_pires/core/models/post.dart';
import 'posts_data_source.dart';

class FirestorePostsDataSource implements PostsDataSource {
  final CollectionReference _collection = FirebaseFirestore.instance.collection(
    'posts',
  );

  @override
  Future<List<Post>> getPosts() async {
    final snapshot =
        await _collection.orderBy('lastUpdatedAt', descending: true).get();
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Post.fromJson(doc.id, data);
    }).toList();
  }

  @override
  Future<void> createPost(Post post) async {
    await _collection.add(post.toJson());
  }

  @override
  Future<void> updatePost(Post post) async {
    await _collection.doc(post.id).update(post.toJson());
  }
}
