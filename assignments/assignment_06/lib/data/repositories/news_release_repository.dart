import 'package:assignment_06/data/models/models.dart';
import 'package:dio/dio.dart';

class NewsReleaseRepository {
  final Dio dio;

  const NewsReleaseRepository({
    required this.dio,
  });

  Future<NewsRelease> read(final String id) async {
    final Response<dynamic> response = await dio.get(
      'https://hubblesite.org/api/v3/news_release/$id',
    );

    return NewsRelease.fromMap(response.data);
  }
}
