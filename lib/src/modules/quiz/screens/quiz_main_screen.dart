import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yo_quiz_app/src/core/models/quiz_play.dart';
import 'package:yo_quiz_app/src/core/widgets/quiz_image.dart';
import 'package:yo_quiz_app/src/modules/quiz/provider/quiz_play_provider.dart';
import 'package:yo_quiz_app/src/modules/quiz/screens/question_play_screen.dart';
import 'package:yo_quiz_app/src/modules/quiz/widgets/text_description.dart';

class QuizMainScreen extends StatelessWidget {
  static const String routeName = "/quiz-main";

  const QuizMainScreen({Key? key}) : super(key: key);

  void _closeQuiz(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final quizId = ModalRoute.of(context)!.settings.arguments as String;

    // Provider.of<QuizPlayProvider>(context).loadQuiz(quizId);
    final appBar = AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      foregroundColor: Theme.of(context).colorScheme.primary,
      actions: [
        IconButton(
          onPressed: () => _closeQuiz(context),
          icon: Icon(Icons.close),
        ),
        Spacer(),
      ],
      // iconTheme: IconThemeData(color: Colors.white),
      elevation: 0.0,
    );

    void _startTheQuiz(BuildContext context) {
      Navigator.of(context).pushNamed(QuestionPlayScreen.routeName);
      
      // Todo: start in provider

    }

    return Scaffold(
      appBar: appBar,

      body: FutureBuilder<QuizPlay?>(
        future: Provider.of<QuizPlayProvider>(context).loadQuiz(quizId),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Icon(
                Icons.error,
                color: Theme.of(context).colorScheme.error,
                size: 200,
              ),
            );
          } else if (snapshot.hasData && snapshot.data == null) {
            return Center(
              child: Text("null"),
            );
          }

          final quizPlay = snapshot.data!;

          final minHeight = mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top;

          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: minHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      QuizImage(
                        quizPlay.quizImage,
                        height: 250,
                        title: quizPlay.title,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Text(
                                  quizPlay.description,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    fontSize: Theme.of(context)
                                        .textTheme
                                        .headline6!
                                        .fontSize,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            TextDescription(title: "Content"),
                            TextDescription(
                              title: "Created",
                              description: quizPlay.created,
                            ),
                            TextDescription(
                              title: "Question Count",
                              description: quizPlay.questionCount.toString(),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed:() => _startTheQuiz(context),
                        child: Center(
                          child: Text(
                            "Start quiz",
                            style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .fontSize),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
