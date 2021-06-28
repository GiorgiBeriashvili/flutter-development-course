import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:dio/dio.dart';
import 'package:final_examination/core/exceptions.dart';
import 'package:final_examination/data/models/models.dart';

class TodoRepository {
  late final String userId;
  late final Dio dio;

  late final firestore.CollectionReference<Todo> todos;

  TodoRepository({
    required this.userId,
    required this.dio,
  }) : todos = firestore.FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('todos')
            .withConverter<Todo>(
              fromFirestore: (snapshot, options) => Todo.fromJson(
                snapshot.data()!,
              ),
              toFirestore: (todo, options) => todo.toJson(),
            );

  Future<void> delete(Todo todo) async => await todos
      .doc(todo.id)
      .delete()
      .catchError((error) => throw TodoException(error));

  Future<void> create(Todo todo) async => await todos
      .doc(todo.id)
      .set(todo)
      .catchError((error) => throw TodoException(error));

  Stream<List<Todo>> readAll() => todos.orderBy('title').snapshots().map(
        (snapshot) => snapshot.docs.map((document) => document.data()).toList(),
      );

  Future<void> update(Todo todo) async => await todos
      .doc(todo.id)
      .update(todo.toJson())
      .catchError((error) => throw TodoException(error));
}
