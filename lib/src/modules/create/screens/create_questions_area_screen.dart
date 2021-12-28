import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yo_quiz_app/src/modules/auth/screens/auth_wrapper_screen.dart';
import 'package:yo_quiz_app/src/modules/create/models/question.dart';
import 'package:yo_quiz_app/src/modules/create/provider/create_quiz_provider.dart';
import 'package:yo_quiz_app/src/modules/create/screens/create_question_screen.dart';

import '../constants/constants.dart' as constants;

class CreateQuestionsAreaScreen extends StatefulWidget {
  static const String routeName = "/create-questions-area";

  const CreateQuestionsAreaScreen({Key? key}) : super(key: key);

  @override
  State<CreateQuestionsAreaScreen> createState() =>
      _CreateQuestionsAreaScreenState();
}

class _CreateQuestionsAreaScreenState extends State<CreateQuestionsAreaScreen> {
  // todo: delete
  late List<Question> _questions;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  void _closeCreateQuiz() {
    Navigator.pushReplacementNamed(context, AuthWrapper.routeName);
    Provider.of<CreateQuizProvider>(context, listen: false).cancelCreateQuiz();
  }

  void _goBackToCreateQuizScreen() {
    Navigator.pop(context);
  }

  // void _createQuestion() async {
  void _createQuestion() {
    // await Navigator.of(context).pushNamed(CreateQuestionScreen.routeName);

    final questionsCount =
        Provider.of<CreateQuizProvider>(context, listen: false).questions.length;
    if (questionsCount >= constants.MAX_QUESTIONS_COUNT) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Max cuestions count is 30.")));
    } else {
      Navigator.of(context).pushNamed(CreateQuestionScreen.routeName);
    }
  }

  void _loadQuestions() {
    _questions = context.read<CreateQuizProvider>().questions;
  }

  void _goToCreateQuestionScreen(String id) {
    Navigator.of(context)
        .pushNamed(CreateQuestionScreen.routeName, arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final appBar = AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      foregroundColor: Theme.of(context).colorScheme.primary,
      actions: [
        IconButton(
          onPressed: _closeCreateQuiz,
          icon: Icon(Icons.close),
        ),
        Spacer(),
        IconButton(
            onPressed: _goBackToCreateQuizScreen,
            icon: Icon(Icons.description)),
      ],
      // iconTheme: IconThemeData(color: Colors.white),
      elevation: 0.0,
    );

    final questions = Provider.of<CreateQuizProvider>(context).questions;

    return WillPopScope(
      onWillPop: () async {
        _goBackToCreateQuizScreen();
        return false;
      },
      child: Scaffold(
        appBar: appBar,
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: mediaQuery.size.height -
                    appBar.preferredSize.height -
                    mediaQuery.padding.top,
                child: GridView.builder(
                  padding: EdgeInsets.all(8),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  // itemCount: _questions.length,
                  itemCount: questions.length,
                  itemBuilder: (_, i) => GridTile(
                    child: GestureDetector(
                      onTap: () {
                        _goToCreateQuestionScreen(questions[i].id);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          // Todo: variant colors when question
                          color: Theme.of(context).colorScheme.primaryVariant,
                        ),
                        child: Center(
                          child: Text(
                            // _questions[i].question,
                            questions[i].question,
                            style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .fontSize,
                                color: Theme.of(context).colorScheme.onPrimary),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _createQuestion,
          child: Icon(Icons.note_add),
        ),
      ),
    );
  }
}
