import 'package:flutter/material.dart';

class QuizImage extends StatelessWidget {
  final String? quizImage;
  final double? height;
  final double? iconSize;
  final String? title;

  const QuizImage(
    this.quizImage, {
    Key? key,
    this.height = 200,
    this.iconSize = 100,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;


    return SizedBox(
      height: height,
      child: Stack(
        children: [
          quizImage != null
              ? Image.network(
                  quizImage!,
                  height: double.infinity,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : Container(
                  height: double.infinity,
                  color: colorScheme.primary,
                  child: Center(
                    child: Icon(
                      Icons.quiz,
                      size: iconSize,
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
          if (title != null)
            Positioned(
              bottom: 10,
              left: 10,
              child: Container(
                padding: EdgeInsets.all(10),
                color: colorScheme.background.withOpacity(0.6),
                child: Text(title!,
                style: TextStyle(
                  fontSize: textTheme.headline5!.fontSize,
                  letterSpacing: 2.0,
                  color: colorScheme.onBackground
                ),),
              ),
            )
        ],
      ),
    );
  }
}
