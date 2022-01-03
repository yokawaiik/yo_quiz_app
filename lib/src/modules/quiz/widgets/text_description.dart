import 'package:flutter/material.dart';

class TextDescription extends StatelessWidget {
  final String title;
  final String? description;

  const TextDescription({
    Key? key,
    required this.title,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: description != null
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: description != null
                  ? textTheme.headline6!.fontSize
                  : textTheme.headline5!.fontSize,
            ),
          ),
          if (description != null)
            Text(
              description!,
              style: TextStyle(
                fontSize: textTheme.headline6!.fontSize,
              ),
            ),
        ],
      ),
    );
  }
}
