import 'package:flutter/material.dart';

class AppBottomNavigationBar extends StatefulWidget {
  AppBottomNavigationBar({Key? key}) : super(key: key);

  @override
  _AppBottomNavigationBarState createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  int _currentIndex = 0;

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
          icon: Icon(Icons.add_circle),
          label: "Add",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
        ),
      ],
      onTap: (v) {
        setState(() {
          _currentIndex = v;
        });
      },
    );
  }
}
