import 'package:trivia/controllers/question_controller.dart';
import 'package:trivia/models/models.dart';
import 'package:flutter/material.dart';

class Trivia extends StatefulWidget {
  final List<Question> questions;

  const Trivia({Key? key, required this.questions}) : super(key: key);

  @override
  _TriviaState createState() => _TriviaState();
}

class _TriviaState extends State<Trivia> {
  late Question _question = widget.questions.first;
  late List<String> _answers = shuffledAnswers(widget.questions.first.answers);
  int _questionIndex = 0;
  int _score = 0;
  bool _hasFinished = false;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  _question.question,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(16.0),
                child: Container(
                  width: 250,
                  height: 250,
                  child: Image.network(
                    _question.imageUrl,
                    loadingBuilder: (context, child, loadingProgress) =>
                        loadingProgress == null
                            ? child
                            : Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
          _hasFinished
              ? Center(
                  child: OutlinedButton(
                    child: Text("Restart"),
                    onPressed: () => setState(() {
                      _question = widget.questions.first;
                      _answers = shuffledAnswers(
                        widget.questions.first.answers,
                      );
                      _questionIndex = 0;
                      _score = 0;
                      _hasFinished = false;
                    }),
                  ),
                )
              : Column(
                  children: List.generate(
                    widget.questions[_questionIndex].answers.length ~/ 2,
                    (rowIndex) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        widget.questions[_questionIndex].answers.length ~/ 2,
                        (columnIndex) => SizedBox(
                          width: 150.0,
                          child: OutlinedButton(
                            child: Text(
                              indexedAnswer(
                                _answers,
                                _questionIndex,
                                rowIndex,
                                columnIndex,
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onPressed: () {
                              setState(() {
                                if (indexedAnswer(
                                      _answers,
                                      _questionIndex,
                                      rowIndex,
                                      columnIndex,
                                    ) ==
                                    widget.questions[_questionIndex]
                                        .correctAnswer) {
                                  _score++;
                                }

                                if (_questionIndex ==
                                    widget.questions.length - 1) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text("End of Trivia!"),
                                      content: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 32.0,
                                        ),
                                        child: Text(
                                          "Score: $_score/${_questionIndex + 1}",
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: Text("Close"),
                                        ),
                                      ],
                                    ),
                                  );

                                  setState(() => _hasFinished = true);
                                } else {
                                  _questionIndex++;
                                  _question = widget.questions[_questionIndex];
                                  _answers = shuffledAnswers(
                                    widget.questions[_questionIndex].answers,
                                  );
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      );
}
