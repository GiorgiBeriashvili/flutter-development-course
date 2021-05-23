import 'package:assignment_05/data/models/models.dart';
import 'package:dio/dio.dart';

class PostRepository {
  final Dio dio;

  const PostRepository({
    required this.dio,
  });

  Future<List<Post>> create(
    final List<Post> posts,
    final Map<String, dynamic> post,
  ) async {
    final Response<dynamic> response = await dio.post(
      'https://jsonplaceholder.typicode.com/posts',
      data: post,
    );

    posts.insert(0, Post.fromMap(response.data));

    return posts;
  }

  Future<List<Post>> delete(final List<Post> posts, final int postId) async {
    await dio.delete(
      'https://jsonplaceholder.typicode.com/posts/$postId',
    );

    posts.removeWhere((post) => post.id == postId);

    return posts;
  }

  Future<List<Post>> readAll(final int userId) async {
    final Response<List<dynamic>> response = await dio.get(
      'https://jsonplaceholder.typicode.com/posts',
      queryParameters: {'userId': userId},
    );

    return response.data!.map((map) => Post.fromMap(map)).toList();
  }
}
