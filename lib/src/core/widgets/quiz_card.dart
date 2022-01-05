import 'package:flutter/material.dart';
import 'package:yo_quiz_app/src/core/widgets/quiz_image.dart';
import 'package:yo_quiz_app/src/core/models/preview_quiz.dart';
import 'package:yo_quiz_app/src/modules/quiz/screens/quiz_main_screen.dart';

class QuizCard extends StatelessWidget {
  Function? onLongPress;
  final double cardHeight;

  QuizCard({
    Key? key,
    required this.quiz,
    this.onLongPress, 
    this.cardHeight = 200,
  }) : super(key: key);

  final PreviewQuiz quiz;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(QuizMainScreen.routeName, arguments: quiz.id);
      },
      onLongPress: onLongPress != null ? () => onLongPress!() : null,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            QuizImage(
              quiz.quizImage,
              title: quiz.title,
              height: cardHeight,
            ),
          ],
        ),
      ),
    );
  }
}
