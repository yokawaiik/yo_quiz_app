import 'package:flutter/material.dart';

class QuestionPlayScreen extends StatefulWidget {
  static const String routeName = "/question-play";
  const QuestionPlayScreen({ Key? key }) : super(key: key);

  @override
  State<QuestionPlayScreen> createState() => _QuestionPlayScreenState();
}

class _QuestionPlayScreenState extends State<QuestionPlayScreen> {


  void _showModalDialogCloseQuiz() {
    // todo: 
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {

        return false;
      },
      child: Scaffold(
        
      ),
    );
  }
}