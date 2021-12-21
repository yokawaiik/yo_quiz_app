import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:yo_quiz_app/src/modules/main_navigator/widgets/app_bottom_navigation_bar.dart';
import 'package:yo_quiz_app/src/modules/auth/provider/auth_provider.dart';
import 'package:yo_quiz_app/src/modules/profile/screens/profile_screen.dart';

class MainNavigatorScreen extends StatefulWidget {
  static const String routeName = "/main";

  const MainNavigatorScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigatorScreen> createState() => _MainNavigatorScreenState();
}

class _MainNavigatorScreenState extends State<MainNavigatorScreen> {
  late Widget _currentScreen;

  late final List<Widget> _screenList;

  late PageController _pageController;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      initialPage: 0,
      keepPage: true,
    );

    _screenList = [
      // Todo: add real screen here
      Center(
        child: Text("home"),
      ),
      Center(
        child: Text("add"),
      ),
      ProfileScreen(),
    ];

    _currentScreen = _screenList[0];
  }

  void _navigate(int index) {
    setState(() {
      _currentScreen = _screenList[index];
      _pageController.animateToPage(
        index,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemBuilder: (BuildContext context, int index) {
          return _currentScreen;
        },
      ),
      bottomNavigationBar: AppBottomNavigationBar(functionNavigate: _navigate),
    );
  }
}
