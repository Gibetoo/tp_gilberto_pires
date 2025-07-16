import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp_gilberto_pires/data/repositories/post_repository.dart';
import 'post_event.dart';
import 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostsRepository repository;

  PostBloc({required this.repository}) : super(const PostState()) {
    on<PostFetched>(_onFetched);
    on<PostCreated>(_onCreated);
    on<PostUpdated>(_onUpdated);
  }

  Future<void> _onFetched(PostFetched event, Emitter<PostState> emit) async {
    emit(state.copyWith(status: PostStatus.loading));
    try {
      final posts = await repository.getPosts();
      if (posts.isEmpty) {
        emit(state.copyWith(status: PostStatus.empty, posts: []));
      } else {
        emit(state.copyWith(status: PostStatus.success, posts: posts));
      }
    } catch (e) {
      emit(
        state.copyWith(status: PostStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  Future<void> _onCreated(PostCreated event, Emitter<PostState> emit) async {
    try {
      await repository.createPost(event.post);
      add(PostFetched());
      emit(state.copyWith(status: PostStatus.success));
    } catch (e) {
      emit(
        state.copyWith(status: PostStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  Future<void> _onUpdated(PostUpdated event, Emitter<PostState> emit) async {
    try {
      await repository.updatePost(event.post);
      add(PostFetched());
    } catch (e) {
      emit(
        state.copyWith(status: PostStatus.failure, errorMessage: e.toString()),
      );
    }
  }
}
