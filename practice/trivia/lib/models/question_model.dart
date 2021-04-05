class Question {
  final String question;
  final String imageUrl;
  final String correctAnswer;
  final List<String> answers;

  const Question({
    required this.question,
    required this.imageUrl,
    required this.correctAnswer,
    required this.answers,
  });
}
