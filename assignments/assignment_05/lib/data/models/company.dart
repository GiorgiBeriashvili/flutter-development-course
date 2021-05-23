import 'dart:convert';

import 'package:equatable/equatable.dart';

class Company extends Equatable {
  final String name;
  final String catchPhrase;
  final String businessSlogan;

  const Company({
    required this.name,
    required this.catchPhrase,
    required this.businessSlogan,
  });

  @override
  List<Object> get props => [
        name,
        catchPhrase,
        businessSlogan,
      ];

  Company copyWith({
    String? name,
    String? catchPhrase,
    String? bs,
  }) =>
      Company(
        name: name ?? this.name,
        catchPhrase: catchPhrase ?? this.catchPhrase,
        businessSlogan: bs ?? this.businessSlogan,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'catchPhrase': catchPhrase,
        'bs': businessSlogan,
      };

  factory Company.fromMap(Map<String, dynamic> map) => Company(
        name: map['name'],
        catchPhrase: map['catchPhrase'],
        businessSlogan: map['bs'],
      );

  String toJson() => json.encode(toMap());

  factory Company.fromJson(String source) => Company.fromMap(
        json.decode(source),
      );

  @override
  String toString() =>
      'Company(name: $name, catchPhrase: $catchPhrase, businessSlogan: $businessSlogan)';
}
