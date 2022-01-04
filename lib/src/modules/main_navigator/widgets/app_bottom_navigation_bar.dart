import 'package:flutter/material.dart';
import 'package:yo_quiz_app/src/modules/create/screens/create_quiz_screen.dart';
import 'package:yo_quiz_app/src/modules/profile/screens/profile_screen.dart';

import '../constants/constants.dart' as constants;

class AppBottomNavigationBar extends StatefulWidget {
  final Function functionNavigate;
  AppBottomNavigationBar({Key? key, required this.functionNavigate})
      : super(key: key);

  @override
  _AppBottomNavigationBarState createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  int _currentIndex = constants.INITIAL_PAGE_INDEX;


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      // showSelectedLabels: false,
      // showUnselectedLabels: false,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.public),
          label: "Public",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: "Added quizzes",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
      onTap: (int v) {
        setState(() {
          _currentIndex = v;
          widget.functionNavigate(_currentIndex);
        });
      },
    );
  }
}
