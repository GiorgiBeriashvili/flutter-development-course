import 'package:trivia/models/models.dart';

class QuestionRepository {
  static const _questions = <Question>[
    Question(
      question: "Which planet of the Solar System is depicted below?",
      imageUrl: "https://source.unsplash.com/ScBkW9AKgcA/250x250",
      correctAnswer: "Neptune",
      answers: [
        "Neptune",
        "Earth",
        "Saturn",
        "Jupiter",
      ],
    ),
    Question(
      question: "In which place is the planet below ordered from the Sun?",
      imageUrl: "https://source.unsplash.com/yEauzeZU6xo/250x250",
      correctAnswer: "Third",
      answers: [
        "Third",
        "First",
        "Second",
        "Fourth",
      ],
    ),
    Question(
      question:
          "Which mythology has a deity of the same name as the planet below?",
      imageUrl: "https://source.unsplash.com/N3BQHYOVq5E/250x250",
      correctAnswer: "Roman",
      answers: [
        "Roman",
        "Greek",
        "Egyptian",
        "Kartvelian",
      ],
    ),
  ];

  List<Question> fetch() => _questions;
}
