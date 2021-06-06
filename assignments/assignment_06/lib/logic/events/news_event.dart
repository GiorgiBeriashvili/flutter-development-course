part of '../blocs/news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();

  @override
  List<Object> get props => [];
}

class NewsStarted extends NewsEvent {
  @override
  String toString() => 'NewsStarted {}';
}
