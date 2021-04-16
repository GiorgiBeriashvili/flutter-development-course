import 'dart:io';

import 'package:assignment_03/app.dart';
import 'package:assignment_03/constants.dart' as constants;
import 'package:assignment_03/repositories/planet_repository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late PlanetRepository planetRepository;

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
