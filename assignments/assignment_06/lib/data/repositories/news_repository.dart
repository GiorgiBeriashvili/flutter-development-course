import 'package:assignment_06/data/models/models.dart';
import 'package:dio/dio.dart';

class NewsRepository {
  final Dio dio;

  const NewsRepository({
    required this.dio,
  });

  Future<List<News>> readAll() async {
    final Response<List<dynamic>> response = await dio.get(
      'https://hubblesite.org/api/v3/news',
      queryParameters: {'page': 'all'},
    );

    return response.data!.map((map) => News.fromMap(map)).toList();
  }
}
