import 'package:assignment_05/data/models/models.dart';
import 'package:dio/dio.dart';

class UserRepository {
  final Dio dio;

  const UserRepository({
    required this.dio,
  });

  Future<List<User>> readAll() async {
    final Response<List<dynamic>> response = await dio.get(
      'https://jsonplaceholder.typicode.com/users',
    );

    return response.data!.map((map) => User.fromMap(map)).toList();
  }
}
