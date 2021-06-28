part of '../blocs/todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();

  @override
  List<Object> get props => [];
}

class TodoInitial extends TodoState {
  @override
  String toString() => 'TodoInitial {}';
}

class TodoLoadInProgress extends TodoState {
  @override
  String toString() => 'TodoLoadInProgress {}';
}

class TodoLoadSuccess extends TodoState {
  final List<Todo> todos;

  const TodoLoadSuccess({required this.todos});

  @override
  List<Object> get props => [todos];

  @override
  String toString() => 'TodoLoadSuccess { todos: $todos }';
}

class TodoLoadFailure extends TodoState {
  final TodoException exception;

  const TodoLoadFailure({required this.exception});

  @override
  List<Object> get props => [exception];

  @override
  String toString() => 'TodoLoadFailure { exception: $exception }';
}

class TodoDeletedSuccess extends TodoState {
  final String message;

  const TodoDeletedSuccess({required this.message});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'TodoLoadSuccess { message: $message }';
}
