import 'package:flutter/material.dart';
import 'package:yo_quiz_app/src/modules/create/screens/create_quiz_screen.dart';
import 'package:yo_quiz_app/src/modules/profile/screens/profile_screen.dart';

class AppBottomNavigationBar extends StatefulWidget {
  final Function functionNavigate;
  AppBottomNavigationBar({Key? key, required this.functionNavigate})
      : super(key: key);

  @override
  _AppBottomNavigationBarState createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  int _currentIndex = 0;

  void _popupSelect(BuildContext context, int v) {
    switch (v) {
      case 0:
        Navigator.of(context).pushNamed(CreateQuizScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: PopupMenuButton(
              onSelected: (int v) {
                _popupSelect(context, v);
              },
              itemBuilder: (_) => [
                    PopupMenuItem(
                      child: Text("Create quiz"),
                      value: 0,
                    ),
                  ],
              child: Icon(Icons.add_circle)),
          label: "Add",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
      onTap: (int v) {
        if (v == 1) return;
        setState(() {
          _currentIndex = v;
          widget.functionNavigate(_currentIndex);
        });
      },
    );
  }
}
