import 'dart:convert';

import 'package:equatable/equatable.dart';

class News extends Equatable {
  final String id;
  final String name;
  final String url;

  const News({
    required this.id,
    required this.name,
    required this.url,
  });

  @override
  List<Object> get props => [
        id,
        name,
        url,
      ];

  News copyWith({
    String? id,
    String? name,
    String? url,
  }) =>
      News(
        id: id ?? this.id,
        name: name ?? this.name,
        url: url ?? this.url,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'url': url,
      };

  factory News.fromMap(Map<String, dynamic> map) => News(
        id: map['news_id'],
        name: map['name'],
        url: map['url'],
      );

  String toJson() => json.encode(toMap());

  factory News.fromJson(String source) => News.fromMap(json.decode(source));

  @override
  String toString() => 'News(id: $id, name: $name, url: $url)';
}
