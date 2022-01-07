import 'package:flutter/material.dart';
import 'package:yo_quiz_app/src/core/widgets/quiz_image.dart';
import 'package:yo_quiz_app/src/modules/quiz/screens/quiz_main_screen.dart';

class QuizCard extends StatelessWidget {
  final Function? onLongPress;
  final double cardHeight;


  final String id;
  final String? image;
  final String? title;

  const QuizCard({
    Key? key,
    required this.id,
    required this.image,
    required this.title,
    this.onLongPress, 
    this.cardHeight = 200,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(QuizMainScreen.routeName, arguments: id);
      },
      onLongPress: onLongPress != null ? () => onLongPress!() : null,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Column(
          children: [
            QuizImage(
              image,
              title: title,
              height: cardHeight,
              iconSize: 80,
            ),
          ],
        ),
      ),
    );
  }
}
