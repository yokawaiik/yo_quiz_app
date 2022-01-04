import 'package:flutter/material.dart';
import 'package:yo_quiz_app/src/modules/quiz/models/game_answer.dart';

class AnswersArea extends StatelessWidget {
  final List<GameAnswer> answers;
  final Function selectAnswer;

  const AnswersArea({
    Key? key,
    required this.answers,
    required this.selectAnswer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      separatorBuilder: (_, __) {
        return const SizedBox(
          height: 20,
        );
      },
      padding: EdgeInsets.all(10),
      shrinkWrap: true,
      itemCount: answers.length,
      itemBuilder: (_, int i) {
        // print("ListView.separated ${currentQuestion.answers[i].isUserAnswer}");
        final answer = answers[i];

        return GestureDetector(
          key: Key(i.toString()),
          onTap: answer.isUserAnswer ? null : () => selectAnswer(i),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              color: (() {
                if (answer.isUserAnswer && !answer.isRight) {
                  return Colors.red;
                } else if (answer.isUserAnswer && answer.isRight) {
                  return Colors.green;
                } else {
                  return Theme.of(context).colorScheme.primary.withOpacity(0.5);
                }
              })(),
              child: Text(
                answer.text,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: Theme.of(context).textTheme.headline6!.fontSize,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
