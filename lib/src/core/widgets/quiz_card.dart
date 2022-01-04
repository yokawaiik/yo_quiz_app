import 'package:flutter/material.dart';
import 'package:yo_quiz_app/src/core/widgets/quiz_image.dart';
import 'package:yo_quiz_app/src/modules/home/models/available_quiz.dart';
import 'package:yo_quiz_app/src/modules/quiz/screens/quiz_main_screen.dart';

class QuizCard extends StatelessWidget {
  const QuizCard({
    Key? key,
    required this.quiz,
  }) : super(key: key);

  final AvailableQuiz quiz;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
            QuizMainScreen.routeName,
            arguments: quiz.id);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            QuizImage(
              quiz.quizImage,
              title: quiz.title,
            ),
          ],
        ),
      ),
    );
  }
}