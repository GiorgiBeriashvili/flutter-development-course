import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trivia/app.dart';
import 'package:trivia/repositories/repositories.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  final questionRepository = QuestionRepository();

  runApp(
    TriviaApp(
      questionRepository: questionRepository,
    ),
  );
}
