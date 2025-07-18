import 'package:tp_gilberto_pires/core/models/post.dart';

abstract class PostEvent {}

class PostFetched extends PostEvent {}

class PostCreated extends PostEvent {
  final Post post;

  PostCreated(this.post);
}

class PostUpdated extends PostEvent {
  final Post post;

  PostUpdated(this.post);
}
