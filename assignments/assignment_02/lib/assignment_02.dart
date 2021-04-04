import 'dart:io';
import 'dart:math';

class DiceGame {
  final _scores = {
    'player': 0,
    'computer': 0,
  };

  void run() {
    start();

    process();

    evaluate();
  }

  void start() => stdout.writeln(
        'The game has begun. '
        'Enter `exit` to finish the game. '
        'Enter anything else to move onto next round.\n',
      );

  void process() {
    stdout.write('> ');

    while (stdin.readLineSync() != 'exit') {
      final dicePoints = {
        'player': 0,
        'computer': 0,
      };

      stdout.writeln();

      dicePoints['player'] += rollDice() + rollDice();
      stdout.writeln(
        'Player rolled two dices for ${dicePoints["player"]} points combined!',
      );

      dicePoints['computer'] += rollDice() + rollDice();
      stdout.writeln(
        'Computer rolled two dices for ${dicePoints["computer"]} points combined!',
      );

      measureDicePoints(dicePoints);

      stdout.writeln('Current score: ${result()}');

      stdout.write('\n> ');
    }
  }

  int rollDice() => Random().nextInt(6) + 1;

  String result() => '${_scores["player"]}-${_scores["computer"]}';

  void measureDicePoints(Map<String, int> dicePoints) {
    if (dicePoints['player'] > dicePoints['computer']) {
      _scores['player']++;
    } else if (dicePoints['player'] < dicePoints['computer']) {
      _scores['computer']++;
    }
  }

  void evaluate() {
    stdout.writeln();

    if (_scores['player'] > _scores['computer']) {
      stdout.writeln('Player has won the game!');
    } else if (_scores['player'] < _scores['computer']) {
      stdout.writeln('Computer has won the game!');
    } else {
      stdout.writeln('The game ended in a draw!');
    }

    stdout.writeln('Result: ${result()}');
  }
}
