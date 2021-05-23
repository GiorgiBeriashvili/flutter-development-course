part of '../blocs/post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {
  @override
  String toString() => 'PostInitial {}';
}

class PostLoadInProgress extends PostState {
  @override
  String toString() => 'PostLoadInProgress {}';
}

class PostLoadSuccess extends PostState {
  final List<Post> posts;

  const PostLoadSuccess({required this.posts});

  @override
  List<Object> get props => [posts];

  @override
  String toString() => 'PostLoadSuccess { posts: $posts }';
}

class PostLoadFailure extends PostState {
  final DioError exception;

  const PostLoadFailure({required this.exception});

  @override
  List<Object> get props => [exception];

  @override
  String toString() => 'PostLoadFailure { exception: $exception }';
}

class PostDeletedSuccess extends PostState {
  final String message;

  const PostDeletedSuccess({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'PostLoadSuccess { message: $message }';
}
