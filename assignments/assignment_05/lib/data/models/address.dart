import 'dart:convert';

import 'package:assignment_05/data/models/geographic_position.dart';
import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final String street;
  final String suite;
  final String city;
  final String zipCode;
  final GeographicPosition geographicPosition;

  const Address({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipCode,
    required this.geographicPosition,
  });

  @override
  List<Object> get props => [
        street,
        suite,
        city,
        zipCode,
      ];

  Address copyWith({
    String? street,
    String? suite,
    String? city,
    String? zipCode,
    GeographicPosition? geographicPosition,
  }) =>
      Address(
        street: street ?? this.street,
        suite: suite ?? this.suite,
        city: city ?? this.city,
        zipCode: zipCode ?? this.zipCode,
        geographicPosition: geographicPosition ?? this.geographicPosition,
      );

  Map<String, dynamic> toMap() => {
        'street': street,
        'suite': suite,
        'city': city,
        'zipcode': zipCode,
        'geo': geographicPosition.toMap(),
      };

  factory Address.fromMap(Map<String, dynamic> map) => Address(
        street: map['street'],
        suite: map['suite'],
        city: map['city'],
        zipCode: map['zipcode'],
        geographicPosition: GeographicPosition.fromMap(map['geo']),
      );

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) => Address.fromMap(
        json.decode(source),
      );

  @override
  String toString() =>
      'Address(street: $street, suite: $suite, city: $city, zipCode: $zipCode, geographicPosition: $geographicPosition)';
}
