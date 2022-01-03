import 'package:flutter/material.dart';

class TransparentAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function closeAction;
  const TransparentAppBar({Key? key, required this.closeAction})
      : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: kToolbarHeight,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      foregroundColor: Theme.of(context).colorScheme.primary,
      actions: [
        IconButton(
          onPressed: () => closeAction(),
          icon: Icon(Icons.close),
        ),
        Spacer(),
      ],
      // iconTheme: IconThemeData(color: Colors.white),
      elevation: 0.0,
    );
  }
}
