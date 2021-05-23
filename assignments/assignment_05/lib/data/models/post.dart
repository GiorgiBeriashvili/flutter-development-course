import 'dart:convert';

import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int id;
  final int userId;
  final String title;
  final String body;

  const Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  @override
  List<Object> get props => [
        id,
        userId,
        title,
        body,
      ];

  Post copyWith({
    int? id,
    int? userId,
    String? title,
    String? body,
  }) =>
      Post(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        body: body ?? this.body,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'userId': userId,
        'title': title,
        'body': body,
      };

  factory Post.fromMap(Map<String, dynamic> map) => Post(
        id: map['id'],
        userId: map['userId'],
        title: map['title'],
        body: map['body'],
      );

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) => Post.fromMap(
        json.decode(source),
      );

  @override
  String toString() =>
      'Post(id: $id, userId: $userId, title: $title, body: $body)';
}
