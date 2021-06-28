import 'dart:async';

import 'package:final_examination/core/exceptions.dart';
import 'package:final_examination/data/models/models.dart';
import 'package:final_examination/data/repositories/repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part '../events/todo_event.dart';
part '../states/todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;

  StreamSubscription<List<Todo>>? _todoSubscription;

  TodoBloc({
    required this.todoRepository,
  }) : super(TodoInitial());

  @override
  Stream<TodoState> mapEventToState(
    TodoEvent event,
  ) async* {
    if (event is TodoCreated) {
      yield* _mapTodoCreatedToState(event);
    } else if (event is TodoDeleted) {
      yield* _mapTodoDeletedToState(event);
    } else if (event is TodoStarted) {
      yield* _mapTodoStartedToState();
    } else if (event is TodoUpdated) {
      yield* _mapTodoUpdatedToState(event);
    } else if (event is TodoUpdatedAll) {
      yield* _mapTodoUpdatedAllToState(event);
    }
  }

  Stream<TodoState> _mapTodoCreatedToState(
    TodoCreated event,
  ) async* {
    yield TodoLoadInProgress();

    try {
      await todoRepository.create(
        Todo.fromJson(event.todo),
      );
    } on TodoException catch (exception) {
      yield TodoLoadFailure(exception: exception);
    }
  }

  Stream<TodoState> _mapTodoDeletedToState(
    TodoDeleted event,
  ) async* {
    yield TodoLoadInProgress();

    try {
      await todoRepository.delete(event.todo);
    } on TodoException catch (exception) {
      yield TodoLoadFailure(exception: exception);
    }
  }

  Stream<TodoState> _mapTodoStartedToState() async* {
    yield TodoLoadInProgress();

    try {
      _todoSubscription?.cancel();

      _todoSubscription = todoRepository.readAll().listen(
            (todos) => add(
              TodoUpdatedAll(todos: todos),
            ),
          );
    } on Exception catch (exception) {
      yield TodoLoadFailure(exception: TodoException(exception));
    }
  }

  Stream<TodoState> _mapTodoUpdatedToState(
    TodoUpdated event,
  ) async* {
    yield TodoLoadInProgress();

    try {
      await todoRepository.update(event.todo);
    } on TodoException catch (exception) {
      yield TodoLoadFailure(exception: exception);
    }
  }

  Stream<TodoState> _mapTodoUpdatedAllToState(
    TodoUpdatedAll event,
  ) async* {
    yield TodoLoadInProgress();

    try {
      yield TodoLoadSuccess(todos: event.todos);
    } on TodoException catch (exception) {
      yield TodoLoadFailure(exception: exception);
    }
  }

  @override
  Future<void> close() {
    _todoSubscription?.cancel();

    return super.close();
  }
}
