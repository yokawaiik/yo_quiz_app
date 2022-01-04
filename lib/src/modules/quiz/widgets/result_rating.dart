import 'package:flutter/material.dart';
import 'package:yo_quiz_app/src/modules/quiz/widgets/text_in_circle.dart';

class ResultRating extends StatelessWidget {
  final int rating;

  const ResultRating({
    Key? key,
    required this.rating,
  }) : super(key: key);

  Color _colorRating(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    Color color;
    if (rating == 100) {
      color = cs.primary;
    } else if (rating > 90) {
      color = cs.primaryVariant;
    } else if (rating > 80) {
      color = cs.secondary;
    } else if (rating > 60) {
      color = cs.secondaryVariant;
    } else if (rating > 40) {
      color = cs.background;
    } else {
      color = cs.error;
    }

    return color;
  }

  @override
  Widget build(BuildContext context) {
    final color = _colorRating(context);

    return TextInCircle(
      text: rating.toString(),
      textColor: color,
      borderColor: color,
      padding: 30,
      width: 10,
    );
  }
}
