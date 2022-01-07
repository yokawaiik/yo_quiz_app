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

  Widget _dummyImageBuilder(ColorScheme colorScheme, {bool isError = false}) {
    return Container(
      height: double.infinity,
      color: colorScheme.primary,
      child: Center(
        child: Icon(
          isError ? Icons.network_locked : Icons.quiz,
          size: iconSize,
          color: colorScheme.onPrimary,
        ),
      ),
    );
  }

  Widget _loadingBuilder(ColorScheme colorScheme) {
    return Container(
      height: double.infinity,
      color: colorScheme.onPrimary,
      alignment: Alignment.center,
      child: CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    print("QuizImage $quizImage");

    return SizedBox(
      height: height,
      child: Stack(
        children: [
          quizImage != null
              ? Image.network(
                  quizImage!,
                  // "",

                  height: double.infinity,
                  width: double.infinity,
                  errorBuilder: (_, error, stackTrace) {
                    return _dummyImageBuilder(colorScheme, isError: true);
                  },
                  loadingBuilder: (_, child, loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return  _loadingBuilder(colorScheme);;
                  },

                  fit: BoxFit.cover,
                )
              : _dummyImageBuilder(colorScheme),
          if (title != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                color: colorScheme.primary.withOpacity(0.6),
                child: Text(
                  title!,
                  style: TextStyle(
                    fontSize: textTheme.headline5!.fontSize,
                    letterSpacing: 2.0,
                    color: colorScheme.onPrimary,
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
