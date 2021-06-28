part of '../blocs/authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationInitialized extends AuthenticationEvent {
  @override
  String toString() => 'AuthenticationInitialized {}';
}

class AuthenticationStarted extends AuthenticationEvent {
  final int userId;

  const AuthenticationStarted({required this.userId});

  @override
  String toString() => 'AuthenticationStarted { userId: $userId }';
}
