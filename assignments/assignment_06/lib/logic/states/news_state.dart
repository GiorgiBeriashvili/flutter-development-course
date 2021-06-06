part of '../blocs/news_bloc.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitial extends NewsState {
  @override
  String toString() => 'NewsInitial {}';
}

class NewsLoadInProgress extends NewsState {
  @override
  String toString() => 'NewsLoadInProgress {}';
}

class NewsLoadSuccess extends NewsState {
  final List<News> news;

  const NewsLoadSuccess({required this.news});

  @override
  List<Object> get props => [news];

  @override
  String toString() => 'NewsLoadSuccess { news: $news }';
}

class NewsLoadFailure extends NewsState {
  final DioError exception;

  const NewsLoadFailure({required this.exception});

  @override
  List<Object> get props => [exception];

  @override
  String toString() => 'NewsLoadFailure { exception: $exception }';
}

class NewsDeletedSuccess extends NewsState {
  final String message;

  const NewsDeletedSuccess({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'NewsLoadSuccess { message: $message }';
}
