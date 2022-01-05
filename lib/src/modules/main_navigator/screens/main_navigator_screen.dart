import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:yo_quiz_app/src/core/widgets/modal_bottom_navigation.dart';
import 'package:yo_quiz_app/src/modules/create/screens/create_quiz_screen.dart';
import 'package:yo_quiz_app/src/modules/home/screens/home_screen.dart';
import 'package:yo_quiz_app/src/modules/main_navigator/widgets/app_bottom_navigation_bar.dart';
import 'package:yo_quiz_app/src/modules/auth/provider/auth_provider.dart';
import 'package:yo_quiz_app/src/modules/profile/screens/profile_screen.dart';
import 'package:yo_quiz_app/src/modules/public/screen/public_screen.dart';

import '../constants/constants.dart' as constants;

class MainNavigatorScreen extends StatefulWidget {
  static const String routeName = "/main";

  const MainNavigatorScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigatorScreen> createState() => _MainNavigatorScreenState();
}

class _MainNavigatorScreenState extends State<MainNavigatorScreen> {
  late Widget _currentScreen;

  late final List<Widget?> _screenList;

  late PageController _pageController;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      initialPage: constants.INITIAL_PAGE_INDEX,
      keepPage: true,
    );

    _screenList = [
      PublicScreen(),
      HomeScreen(),
      ProfileScreen(),
    ];

    _currentScreen = _screenList[constants.INITIAL_PAGE_INDEX]!;
  }

  void _navigate(int index) {
    // add item

    setState(() {
      _currentScreen = _screenList[index]!;

      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.elasticIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        physics: NeverScrollableScrollPhysics(),
        controller: _pageController,
        itemBuilder: (_, __) {
          return _currentScreen;
        },
      ),
      bottomNavigationBar: AppBottomNavigationBar(functionNavigate: _navigate),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),

      //   onPressed: () {},
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
