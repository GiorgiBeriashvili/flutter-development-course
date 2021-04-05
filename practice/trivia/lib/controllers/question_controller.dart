List<String> shuffledAnswers(List<String> answers) {
  final shuffledAnswers = List<String>.from(answers);

  shuffledAnswers.shuffle();

  return shuffledAnswers;
}

String indexedAnswer(
  List<String> answers,
  int questionIndex,
  int rowIndex,
  int columnIndex,
) =>
    answers[(answers.length ~/ 2) * rowIndex + columnIndex];
