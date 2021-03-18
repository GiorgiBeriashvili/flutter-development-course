import 'dart:io';

import 'package:assignment_01/app.dart';
import 'package:assignment_01/constants.dart' as constants;
import 'package:assignment_01/repositories/planet_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  PlanetRepository planetRepository;

  setUpAll(() {
    planetRepository = PlanetRepository();

    HttpOverrides.global = null;
  });

  testWidgets('AppBar has predefined title', (WidgetTester tester) async {
    final widget = PlanetsApp(
      planetRepository: planetRepository,
    );

    await tester.runAsync(
      () async => await tester.pumpWidget(widget),
    );

    expect(find.text(constants.appTitle), findsOneWidget);
  });
}
