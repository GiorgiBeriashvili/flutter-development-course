import 'package:trivia/constants.dart' as constants;
import 'package:trivia/repositories/repositories.dart';
import 'package:trivia/screens/trivia.dart';
import 'package:flutter/material.dart';

class TriviaApp extends StatelessWidget {
  final QuestionRepository questionRepository;

  const TriviaApp({
    Key? key,
    required this.questionRepository,
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
            body: Trivia(
              questions: questionRepository.fetch(),
            ),
          ),
        ),
      );
}
