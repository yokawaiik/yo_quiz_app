import 'package:flutter/material.dart';

class QuizMainScreen extends StatelessWidget {
  static const String routeName = "/quiz-main";
  const QuizMainScreen({Key? key}) : super(key: key);

  void _closeCreateQuiz(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.primary,
          actions: [
            
            IconButton(
              onPressed: () => _closeCreateQuiz(context),
              icon: Icon(Icons.close),
            ),
            Spacer(),
          ],
          // iconTheme: IconThemeData(color: Colors.white),
          elevation: 0.0,
        ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
