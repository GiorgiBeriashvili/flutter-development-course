import 'package:assignment_01/models/models.dart';

class PlanetRepository {
  static const _planets = <Planet>[
    Planet(
      name: "Neptune",
      imageUrl: "https://source.unsplash.com/ScBkW9AKgcA/250x250",
      description:
          "Neptune is the eighth and farthest-known Solar planet from the Sun.",
    ),
    Planet(
      name: "Earth",
      imageUrl: "https://source.unsplash.com/yEauzeZU6xo/250x250",
      description:
          "Earth is the third planet from the Sun and the only astronomical object known to harbor life.",
    ),
    Planet(
      name: "Mars",
      imageUrl: "https://source.unsplash.com/N3BQHYOVq5E/250x250",
      description:
          "Mars is the fourth planet from the Sun and the second-smallest planet in the Solar System, being larger than only Mercury.",
    ),
  ];

  List<Planet> fetch() => _planets;
}
