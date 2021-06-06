import 'dart:convert';

import 'package:equatable/equatable.dart';

class NewsRelease extends Equatable {
  final String id;
  final String name;
  final String url;
  final String publication;
  final String mission;
  final String abstract;
  final String credits;
  final String imageUrl;

  const NewsRelease({
    required this.id,
    required this.name,
    required this.url,
    required this.publication,
    required this.mission,
    required this.abstract,
    required this.credits,
    required this.imageUrl,
  });

  @override
  List<Object> get props => [
        id,
        name,
        url,
        publication,
        mission,
        abstract,
        credits,
        imageUrl,
      ];

  NewsRelease copyWith({
    String? id,
    String? name,
    String? url,
    String? publication,
    String? mission,
    String? abstract,
    String? credits,
    String? imageUrl,
  }) =>
      NewsRelease(
        id: id ?? this.id,
        name: name ?? this.name,
        url: url ?? this.url,
        publication: publication ?? this.publication,
        mission: mission ?? this.mission,
        abstract: abstract ?? this.abstract,
        credits: credits ?? this.credits,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'url': url,
        'publication': publication,
        'mission': mission,
        'abstract': abstract,
        'credits': credits,
        'imageUrl': imageUrl,
      };

  factory NewsRelease.fromMap(Map<String, dynamic> map) => NewsRelease(
        id: map['news_id'],
        name: map['name'],
        url: map['url'],
        publication: map['publication'],
        mission: map['mission'],
        abstract: map['abstract'],
        credits: map['credits'] ?? '',
        imageUrl: map['keystone_image_2x'],
      );

  String toJson() => json.encode(toMap());

  factory NewsRelease.fromJson(String source) => NewsRelease.fromMap(
        json.decode(source),
      );

  @override
  String toString() => 'NewsRelease(id: $id, name: $name, url: $url, '
      'publication: $publication, mission: $mission, abstract: $abstract, '
      'credits: $credits, imageUrl: $imageUrl)';
}
