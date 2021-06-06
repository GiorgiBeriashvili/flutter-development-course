import 'dart:async';

import 'package:assignment_06/data/models/models.dart';
import 'package:assignment_06/data/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

part '../events/news_event.dart';
part '../states/news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository newsRepository;

  NewsBloc({
    required this.newsRepository,
  }) : super(NewsInitial());

  @override
  Stream<NewsState> mapEventToState(
    NewsEvent event,
  ) async* {
    if (event is NewsStarted) {
      yield NewsLoadInProgress();

      try {
        final news = await newsRepository.readAll();

        yield NewsLoadSuccess(news: news);
      } on DioError catch (exception) {
        yield NewsLoadFailure(exception: exception);
      }
    }
  }
}
