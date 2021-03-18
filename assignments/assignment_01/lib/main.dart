import 'package:assignment_01/app.dart';
import 'package:assignment_01/repositories/planet_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final planetRepository = PlanetRepository();

  runApp(
    PlanetsApp(
      planetRepository: planetRepository,
    ),
  );
}
