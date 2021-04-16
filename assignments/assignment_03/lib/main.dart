import 'package:assignment_03/app.dart';
import 'package:assignment_03/repositories/planet_repository.dart';
import 'package:flutter/material.dart';

void main() async {
  final planetRepository = PlanetRepository();

  runApp(
    PlanetsApp(
      planetRepository: planetRepository,
    ),
  );
}
