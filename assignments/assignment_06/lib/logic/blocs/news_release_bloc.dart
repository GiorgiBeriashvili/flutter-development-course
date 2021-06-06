import 'dart:async';

import 'package:assignment_06/data/models/models.dart';
import 'package:assignment_06/data/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part '../events/news_release_event.dart';
part '../states/news_release_state.dart';

class NewsReleaseBloc extends Bloc<NewsReleaseEvent, NewsReleaseState> {
  final NewsReleaseRepository newsReleaseRepository;

  NewsReleaseBloc({
    required this.newsReleaseRepository,
  }) : super(NewsReleaseInitial());

  @override
  Stream<NewsReleaseState> mapEventToState(
    NewsReleaseEvent event,
  ) async* {
    if (event is NewsReleaseStarted) {
      yield NewsReleaseLoadInProgress();

      try {
        final newsRelease = await newsReleaseRepository.read(event.id);

        yield NewsReleaseLoadSuccess(newsRelease: newsRelease);
      } on DioError catch (exception) {
        yield NewsReleaseLoadFailure(exception: exception);
      }
    }
  }
}
