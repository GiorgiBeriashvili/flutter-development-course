part of '../blocs/todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class TodoCreated extends TodoEvent {
  final Map<String, Object?> todo;

  const TodoCreated({required this.todo});

  @override
  String toString() => 'TodoCreated { todo: $todo }';
}

class TodoDeleted extends TodoEvent {
  final Todo todo;

  const TodoDeleted({required this.todo});

  @override
  String toString() => 'TodoDeleted { todo: $todo }';
}

class TodoStarted extends TodoEvent {
  @override
  String toString() => 'TodoStarted {}';
}

class TodoUpdated extends TodoEvent {
  final Todo todo;

  const TodoUpdated({required this.todo});

  @override
  String toString() => 'TodoUpdated { todo: $todo }';
}

class TodoUpdatedAll extends TodoEvent {
  final List<Todo> todos;

  const TodoUpdatedAll({required this.todos});

  @override
  String toString() => 'TodoUpdatedAll { todos: $todos }';
}
