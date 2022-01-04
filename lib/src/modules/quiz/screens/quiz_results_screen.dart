import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yo_quiz_app/src/core/widgets/transparent_app_bar.dart';
import 'package:yo_quiz_app/src/modules/quiz/models/game_results.dart';
import 'package:yo_quiz_app/src/modules/quiz/provider/quiz_play_provider.dart';
import 'package:yo_quiz_app/src/modules/quiz/screens/quiz_main_screen.dart';
import 'package:yo_quiz_app/src/modules/quiz/widgets/expanded_elevated_button.dart';
import 'package:yo_quiz_app/src/modules/quiz/widgets/result_rating.dart';
import 'package:yo_quiz_app/src/modules/quiz/widgets/text_description.dart';

class QuizResultsScreen extends StatelessWidget {
  static const String routeName = "/quiz-results";
  const QuizResultsScreen({Key? key}) : super(key: key);

  void _closeQuiz(BuildContext context) {
    Navigator.of(context)
        .popUntil((route) => route.settings.name == QuizMainScreen.routeName);
    Provider.of<QuizPlayProvider>(context, listen: false).closeQuiz();
  }

  @override
  Widget build(BuildContext context) {
    // final gameResults =
    //     Provider.of<QuizPlayProvider>(context, listen: true).gameResults;

    // print(gameResults);

    return WillPopScope(
      onWillPop: () async {
        _closeQuiz(context);
        return false;
      },
      child: Scaffold(
        appBar: TransparentAppBar(
          closeAction: () => _closeQuiz(context),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: FutureBuilder<GameResults>(
            future: Provider.of<QuizPlayProvider>(context, listen: false)
                .finishQuiz(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                final results = snapshot.data!;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                 
                      children: [
                        ResultRating(rating: results.rating),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.background.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              TextDescription(
                                title: "Right Answers",
                                description: results.rightAnswers.toString(),
                              ),
                              TextDescription(
                                title: "Wrong Answers",
                                description: results.wrongAnswers.toString(),
                              ),
                              TextDescription(
                                title: "Not Answered",
                                description: results.notAnswered.toString(),
                              ),
                              TextDescription(
                                title: "Total Answers",
                                description: results.totalAnswers.toString(),
                              ),
                              TextDescription(
                                title: "Date",
                                description: results.date,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    ExpandedElevatedButton(
                        text: "Finish", onPressed: () => _closeQuiz(context)),
                  ],
                );
              } else {
                return Center(
                  child: Icon(
                    Icons.error,
                    size: 200,
                    color: Theme.of(context).colorScheme.error,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
