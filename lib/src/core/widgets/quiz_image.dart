import 'package:flutter/material.dart';

class QuizImage extends StatelessWidget {
  final String? quizImage;
  final double? height;
  final double? iconSize;

  const QuizImage(
    this.quizImage, {
    Key? key,
    this.height = 200,
    this.iconSize = 100
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return quizImage != null
        ? Image.network(
            quizImage!,
            height: height,
            width: double.infinity,
            fit: BoxFit.cover,
          )
        : Container(
            height: height,
            color: Theme.of(context).colorScheme.primary,
            child: Center(
              child: Icon(
                Icons.quiz,
                size: iconSize,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          );
  }
}
