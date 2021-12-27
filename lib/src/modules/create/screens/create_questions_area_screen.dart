import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yo_quiz_app/src/modules/auth/screens/auth_wrapper_screen.dart';
import 'package:yo_quiz_app/src/modules/create/provider/create_quiz_provider.dart';
import 'package:yo_quiz_app/src/modules/create/screens/create_question_screen.dart';

class CreateQuestionsAreaScreen extends StatefulWidget {
  static const String routeName = "/create-questions-area";

  const CreateQuestionsAreaScreen({Key? key}) : super(key: key);

  @override
  State<CreateQuestionsAreaScreen> createState() =>
      _CreateQuestionsAreaScreenState();
}

class _CreateQuestionsAreaScreenState extends State<CreateQuestionsAreaScreen> {
  // todo: delete
  List<int> simpleList = [1, 2, 3];

  void _closeCreateQuiz() {
    Navigator.pushReplacementNamed(context, AuthWrapper.routeName);
    Provider.of<CreateQuizProvider>(context, listen: false).cancelCreateQuiz();
  }

  void _goBackToCreateQuestionScreen() {
    Navigator.pop(context);
  }



  void _createQuestion() {
    Navigator.of(context).pushNamed(CreateQuestionScreen.routeName);
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
          onPressed: _goBackToCreateQuestionScreen,
          icon: Icon(Icons.description)
        ),
      ],
      // iconTheme: IconThemeData(color: Colors.white),
      elevation: 0.0,
    );

    return WillPopScope(
      onWillPop: () async {
        _goBackToCreateQuestionScreen();
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
                  itemCount: simpleList.length,
                  itemBuilder: (_, i) => GridTile(
                    child: GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          // Todo: variant colors when question
                          color: Theme.of(context).colorScheme.primaryVariant,
                        ),
                        child: Center(
                          child: Text(
                            "Text $i",
                            style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .fontSize,
                                color: Theme.of(context).colorScheme.onPrimary),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(4),
                  //     color: Theme.of(context).colorScheme.primaryVariant,
                  //   ),
                  //   child: Center(
                  //     child: Text(
                  //       "Text $i",
                  //       style: TextStyle(
                  //           fontSize: Theme.of(context).textTheme.headline5!.fontSize,
                  //           color: Theme.of(context).colorScheme.onPrimary),
                  //     ),
                  //   ),
                  // ),
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
