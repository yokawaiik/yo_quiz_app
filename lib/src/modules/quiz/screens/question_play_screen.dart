import 'package:flutter/material.dart';
import 'package:yo_quiz_app/src/modules/quiz/screens/quiz_main_screen.dart';

class QuestionPlayScreen extends StatefulWidget {
  static const String routeName = "/question-play";
  const QuestionPlayScreen({Key? key}) : super(key: key);

  @override
  State<QuestionPlayScreen> createState() => _QuestionPlayScreenState();
}

class _QuestionPlayScreenState extends State<QuestionPlayScreen> {
  void _showModalDialogCloseQuiz() {
    // todo:
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Text("Do you want close the quiz?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("No"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).popUntil(
                  (route) => route.settings.name == QuizMainScreen.routeName);
            },
            child: Text("Yes"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _showModalDialogCloseQuiz();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.primary,
          actions: [
            IconButton(
              onPressed: () => _showModalDialogCloseQuiz(),
              icon: Icon(Icons.close),
            ),
            Spacer(),
          ],
          // iconTheme: IconThemeData(color: Colors.white),
          elevation: 0.0,
        ),
      ),
    );
  }
}
