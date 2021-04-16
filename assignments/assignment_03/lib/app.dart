import 'package:assignment_03/constants.dart' as constants;
import 'package:assignment_03/repositories/repositories.dart';
import 'package:assignment_03/screens/planet_explorer/planet_explorer.dart';
import 'package:flutter/material.dart';

class PlanetsApp extends StatelessWidget {
  final PlanetRepository planetRepository;

  const PlanetsApp({
    Key? key,
    required this.planetRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              title: Text(constants.appTitle),
              centerTitle: true,
            ),
            body: PlanetExplorer(
              planets: planetRepository.fetch(),
            ),
          ),
        ),
      );
}
