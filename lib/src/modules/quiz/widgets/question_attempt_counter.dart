import 'package:flutter/material.dart';
import 'package:yo_quiz_app/src/modules/quiz/widgets/text_in_circle.dart';

class QuestionAttemptCounter extends StatelessWidget {
  final int attemptAnswers;

  const QuestionAttemptCounter({Key? key, required this.attemptAnswers})
      : super(key: key);

  Color _counterColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (attemptAnswers > 0) {
      return colorScheme.secondary;
    } else {
      return colorScheme.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final counterColor = _counterColor(context);

    return TextInCircle(
      text: attemptAnswers.toString(),
      textColor: counterColor,
      borderColor: counterColor,
    );
  }
}
