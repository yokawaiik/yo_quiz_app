import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yo_quiz_app/src/core/widgets/transparent_app_bar.dart';
import 'package:yo_quiz_app/src/modules/quiz/models/game_results.dart';
import 'package:yo_quiz_app/src/modules/quiz/provider/quiz_play_provider.dart';
import 'package:yo_quiz_app/src/modules/quiz/screens/quiz_main_screen.dart';
import 'package:yo_quiz_app/src/modules/quiz/widgets/expanded_elevated_button.dart';

class QuizResultsScreen extends StatelessWidget {
  static const String routeName = "/quiz-results";
  const QuizResultsScreen({Key? key}) : super(key: key);

  void _closeQuiz(BuildContext context) {
    Navigator.of(context)
        .popUntil((route) => route.settings.name == QuizMainScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(
        closeAction: () => _closeQuiz(context),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder<GameResults?>(
          future: Provider.of<QuizPlayProvider>(context, listen: false).finishQuiz(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator(),);
            }


            final results = snapshot.data!;

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(results.rightAnswers.toString()),
                    Text(results.wrongAnswers.toString()),
                    Text(results.notAnswered.toString()),
                    Text(results.totalQuestions.toString()),
                    Text(results.timestamp.toString()),
                  ],
                ),
                ExpandedElevatedButton(
                    text: "Finish", onPressed: () => _closeQuiz(context)),
              ],
            );
          }
        ),
      ),
    );
  }
}
