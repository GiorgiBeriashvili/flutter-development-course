part of '../blocs/authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {
  @override
  String toString() => 'AuthenticationInitial {}';
}

class AuthenticationLoadInProgress extends AuthenticationState {
  @override
  String toString() => 'AuthenticationLoadInProgress {}';
}

class AuthenticationLoadSuccess extends AuthenticationState {
  final int userId;

  const AuthenticationLoadSuccess({required this.userId});

  @override
  List<Object> get props => [userId];

  @override
  String toString() => 'AuthenticationLoadSuccess { userId: $userId }';
}

class AuthenticationLoadFailure extends AuthenticationState {
  final AuthenticationException exception;

  const AuthenticationLoadFailure({required this.exception});

  @override
  List<Object> get props => [exception];

  @override
  String toString() => 'AuthenticationLoadFailure { exception: $exception }';
}
