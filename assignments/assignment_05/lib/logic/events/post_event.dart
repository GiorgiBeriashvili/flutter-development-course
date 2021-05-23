part of '../blocs/post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();

  @override
  List<Object> get props => [];
}

class PostStarted extends PostEvent {
  final int userId;

  const PostStarted({
    required this.userId,
  });

  @override
  String toString() => 'PostStarted { id: $userId }';
}

class PostCreated extends PostEvent {
  final List<Post> posts;
  final Map<String, dynamic> post;

  const PostCreated({
    required this.posts,
    required this.post,
  });

  @override
  String toString() => 'PostCreated { posts: $posts, post: $post }';
}

class PostDeleted extends PostEvent {
  final List<Post> posts;
  final int postId;

  const PostDeleted({
    required this.posts,
    required this.postId,
  });

  @override
  String toString() => 'PostDeleted { posts: $posts, postId: $postId }';
}
