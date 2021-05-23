import 'dart:convert';

import 'package:equatable/equatable.dart';

class GeographicPosition extends Equatable {
  final double latitude;
  final double longitude;

  const GeographicPosition({
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object> get props => [
        latitude,
        longitude,
      ];

  GeographicPosition copyWith({
    double? latitude,
    double? longitude,
  }) =>
      GeographicPosition(
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
      );

  Map<String, dynamic> toMap() => {
        'lat': latitude,
        'lng': longitude,
      };

  factory GeographicPosition.fromMap(Map<String, dynamic> map) =>
      GeographicPosition(
        latitude: double.parse(map['lat']),
        longitude: double.parse(map['lng']),
      );

  String toJson() => json.encode(toMap());

  factory GeographicPosition.fromJson(String source) =>
      GeographicPosition.fromMap(
        json.decode(source),
      );

  @override
  String toString() =>
      'GeographicPosition(latitude: $latitude, longitude: $longitude)';
}
