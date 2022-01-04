import 'package:flutter/material.dart';

class QuestionArea extends StatelessWidget {
  final String question;

  const QuestionArea({
    Key? key,
    required this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: Theme.of(context).colorScheme.background,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  Text(
                    question,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.headline6!.fontSize,
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
