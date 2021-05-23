import 'dart:async';

import 'package:assignment_05/data/models/models.dart';
import 'package:assignment_05/data/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part '../events/post_event.dart';
part '../states/post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc({
    required this.postRepository,
  }) : super(PostInitial());

  @override
  Stream<PostState> mapEventToState(
    PostEvent event,
  ) async* {
    if (event is PostStarted) {
      yield PostLoadInProgress();

      try {
        final posts = await postRepository.readAll(event.userId);

        yield PostLoadSuccess(posts: posts);
      } on DioError catch (exception) {
        yield PostLoadFailure(exception: exception);
      }
    } else if (event is PostCreated) {
      yield PostLoadInProgress();

      try {
        final posts = await postRepository.create(event.posts, event.post);

        yield PostLoadSuccess(posts: posts);
      } on DioError catch (exception) {
        yield PostLoadFailure(exception: exception);
      }
    } else if (event is PostDeleted) {
      yield PostLoadInProgress();

      try {
        final posts = await postRepository.delete(event.posts, event.postId);

        yield PostDeletedSuccess(message: 'Post has been deleted!');
        yield PostLoadSuccess(posts: posts);
      } on DioError catch (exception) {
        yield PostLoadFailure(exception: exception);
      }
    }
  }
}
