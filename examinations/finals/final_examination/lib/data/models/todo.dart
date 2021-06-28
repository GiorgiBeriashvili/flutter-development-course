import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String id;
  final String title;
  final String task;
  final String description;
  final bool completed;

  const Todo({
    required this.id,
    required this.title,
    required this.task,
    required this.description,
    required this.completed,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        task,
        description,
        completed,
      ];

  Todo copyWith({
    String? id,
    String? title,
    String? task,
    String? description,
    bool? completed,
  }) =>
      Todo(
        id: id ?? this.id,
        title: title ?? this.title,
        task: task ?? this.task,
        description: description ?? this.description,
        completed: completed ?? this.completed,
      );

  factory Todo.fromJson(Map<String, Object?> json) => Todo(
        id: json['id'] as String,
        title: json['title'] as String,
        task: json['task'] as String,
        description: json['description'] as String,
        completed: json['completed'] as bool,
      );

  Map<String, Object?> toJson() => {
        'id': id,
        'title': title,
        'task': task,
        'description': description,
        'completed': completed,
      };

  @override
  String toString() => 'Todo { '
      'id: $id, '
      'title: $title, '
      'task: $task, '
      'description: $description, '
      'completed: $completed '
      '}';
}
