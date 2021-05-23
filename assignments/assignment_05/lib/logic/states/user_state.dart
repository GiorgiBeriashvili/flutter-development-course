part of '../blocs/user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {
  @override
  String toString() => 'UserInitial {}';
}

class UserLoadInProgress extends UserState {
  @override
  String toString() => 'UserLoadInProgress {}';
}

class UserLoadSuccess extends UserState {
  final List<User> users;

  const UserLoadSuccess({required this.users});

  @override
  List<Object> get props => [users];

  @override
  String toString() => 'UserLoadSuccess { users: $users }';
}

class UserLoadFailure extends UserState {
  final DioError exception;

  const UserLoadFailure({required this.exception});

  @override
  List<Object> get props => [exception];

  @override
  String toString() => 'UserLoadFailure { exception: $exception }';
}
