import 'package:flutter/material.dart';

class ExpandedElevatedButton extends StatelessWidget {
  late Function? onPressed;
  late VoidCallback onPressedVoidCallback;

  String text;

  ExpandedElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  ExpandedElevatedButton.voidCallbackFunction({
    Key? key,
    required this.text,
    required this.onPressedVoidCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed == null ? null : () => onPressed!(),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: Theme.of(context).textTheme.headline6!.fontSize),
          ),
        ),
      ),
    );
  }
}
