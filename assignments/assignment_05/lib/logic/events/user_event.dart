part of '../blocs/user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class UserStarted extends UserEvent {
  @override
  String toString() => 'UserStarted {}';
}
