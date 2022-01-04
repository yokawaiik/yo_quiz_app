import 'package:flutter/material.dart';

class TextInCircle extends StatelessWidget {
  final String text;

  final Color textColor;
  final Color borderColor;

  final double padding;
  final double width;

  const TextInCircle({
    Key? key,
    required this.text,
    required this.textColor,
    required this.borderColor,
    this.padding = 20,
    this.width = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        border: Border.all(
          width: width,
          color: borderColor,
        ),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: textTheme.headline4!.fontSize,
          ),
        ),
      ),
    );
  }
}
