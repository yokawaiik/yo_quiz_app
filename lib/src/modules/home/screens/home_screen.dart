import 'package:flutter/material.dart';
import 'package:yo_quiz_app/src/core/widgets/modal_bottom_navigation.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "/home";
  HomeScreen({Key? key}) : super(key: key);

  // var _scaffoldkey = GlobalKey<ScaffoldState>();

  void _showMenu(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (_) => ModalBottomNavigation(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // key: _scaffoldkey,
      // appBar: AppBar(),
      body: Column(
        children: [
          // todo: add listview - my available quiz
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showMenu(context),
        child: Icon(Icons.quiz),
      ),
    );
  }
}
