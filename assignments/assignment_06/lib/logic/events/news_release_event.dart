part of '../blocs/news_release_bloc.dart';

abstract class NewsReleaseEvent extends Equatable {
  const NewsReleaseEvent();

  @override
  List<Object> get props => [];
}

class NewsReleaseStarted extends NewsReleaseEvent {
  final String id;

  const NewsReleaseStarted({required this.id});

  @override
  String toString() => 'NewsReleaseStarted { id: $id }';
}
