part of '../blocs/news_release_bloc.dart';

abstract class NewsReleaseState extends Equatable {
  const NewsReleaseState();

  @override
  List<Object> get props => [];
}

class NewsReleaseInitial extends NewsReleaseState {
  @override
  String toString() => 'NewsReleaseInitial {}';
}

class NewsReleaseLoadInProgress extends NewsReleaseState {
  @override
  String toString() => 'NewsReleaseLoadInProgress {}';
}

class NewsReleaseLoadSuccess extends NewsReleaseState {
  final NewsRelease newsRelease;

  const NewsReleaseLoadSuccess({required this.newsRelease});

  @override
  List<Object> get props => [newsRelease];

  @override
  String toString() => 'NewsReleaseLoadSuccess { newsRelease: $newsRelease }';
}

class NewsReleaseLoadFailure extends NewsReleaseState {
  final DioError exception;

  const NewsReleaseLoadFailure({required this.exception});

  @override
  List<Object> get props => [exception];

  @override
  String toString() => 'NewsReleaseLoadFailure { exception: $exception }';
}

class NewsReleaseDeletedSuccess extends NewsReleaseState {
  final String message;

  const NewsReleaseDeletedSuccess({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'NewsReleaseLoadSuccess { message: $message }';
}
