import 'package:flutter/material.dart';
import 'package:yo_quiz_app/src/core/widgets/modal_bottom_navigation.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "/home";
  HomeScreen({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();

  void _showMenu() {
    showModalBottomSheet(
      isScrollControlled: true,
      
      context: _scaffoldkey.currentState!.context,
      builder: (_) => ModalBottomNavigation(),
    );
  }

  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      // appBar: AppBar(),
      body: Column(),
      floatingActionButton: FloatingActionButton(
        onPressed: _showMenu,
        child: Icon(Icons.quiz),
      ),
    );
  }
}
