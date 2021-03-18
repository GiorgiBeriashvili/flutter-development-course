import 'package:assignment_01/models/models.dart';

class PlanetRepository {
  static const _planets = <Planet>[
    Planet(
      name: "Neptune",
      imageUrl: "https://source.unsplash.com/ScBkW9AKgcA/250x250",
    ),
    Planet(
      name: "Earth",
      imageUrl: "https://source.unsplash.com/yEauzeZU6xo/250x250",
    ),
    Planet(
      name: "Mars",
      imageUrl: "https://source.unsplash.com/N3BQHYOVq5E/250x250",
    ),
  ];

  List<Planet> fetch() => _planets;
}
