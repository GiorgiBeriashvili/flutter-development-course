import 'dart:io';

import 'package:trivia/app.dart';
import 'package:trivia/constants.dart' as constants;
import 'package:trivia/repositories/repositories.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late QuestionRepository questionRepository;

  setUpAll(() {
    questionRepository = QuestionRepository();

    HttpOverrides.global = null;
  });

  testWidgets('AppBar has predefined title', (WidgetTester tester) async {
    final widget = TriviaApp(
      questionRepository: questionRepository,
    );

    await tester.runAsync(
      () async => await tester.pumpWidget(widget),
    );

    expect(find.text(constants.appTitle), findsOneWidget);
  });
}
