import 'package:assignment_01/constants.dart' as constants;
import 'package:assignment_01/repositories/repositories.dart';
import 'package:assignment_01/screens/planet_explorer.dart';
import 'package:flutter/material.dart';

class PlanetsApp extends StatelessWidget {
  final PlanetRepository planetRepository;

  const PlanetsApp({
    Key key,
    @required this.planetRepository,
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
