import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yo_quiz_app/src/core/widgets/transparent_app_bar.dart';
import 'package:yo_quiz_app/src/modules/quiz/provider/quiz_play_provider.dart';
import 'package:yo_quiz_app/src/modules/quiz/screens/quiz_main_screen.dart';
import 'package:yo_quiz_app/src/modules/quiz/screens/quiz_results_screen.dart';
import 'package:yo_quiz_app/src/modules/quiz/widgets/expanded_elevated_button.dart';

class QuestionPlayScreen extends StatefulWidget {
  static const String routeName = "/question-play";
  const QuestionPlayScreen({Key? key}) : super(key: key);

  @override
  State<QuestionPlayScreen> createState() => _QuestionPlayScreenState();
}

class _QuestionPlayScreenState extends State<QuestionPlayScreen> {
  @override
  void initState() {
    super.initState();

    Provider.of<QuizPlayProvider>(context, listen: false).startQuiz();
  }

  void _nextQuestion(bool isCurrentQuestionLast) {
    final quizPlayProvider =
        Provider.of<QuizPlayProvider>(context, listen: false);

    if (isCurrentQuestionLast) {
      Navigator.of(context).pushReplacementNamed(QuizResultsScreen.routeName);
      quizPlayProvider.finishQuiz();
    } else {
      quizPlayProvider.nextQuestion();
    }
  }

  void _showModalDialogCloseQuiz() {
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
              Provider.of<QuizPlayProvider>(context, listen: false).closeQuiz();
            },
            child: Text("Yes"),
          ),
        ],
      ),
    );
  }

  void _selectAnswer(int index) {
    Provider.of<QuizPlayProvider>(context, listen: false).selectAnswer(index);
  }

  @override
  Widget build(BuildContext context) {
    final quizPlayProvider =
        Provider.of<QuizPlayProvider>(context, listen: true);

    final currentQuestion = quizPlayProvider.currentQuestion!;
    final isCurrentQuestionLast = quizPlayProvider.isCurrentQuestionLast!;

    return WillPopScope(
      onWillPop: () async {
        _showModalDialogCloseQuiz();
        return true;
      },
      child: Scaffold(
        appBar: TransparentAppBar(closeAction: _showModalDialogCloseQuiz),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      color: Theme.of(context).colorScheme.background,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Row(
                          children: [
                            Text(
                              currentQuestion.question,
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
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  ListView.separated(
                    separatorBuilder: (_, __) {
                      return const SizedBox(
                        height: 20,
                      );
                    },
                    // padding: EdgeInsets.all(10),
                    shrinkWrap: true,
                    itemCount: currentQuestion.answers.length,
                    itemBuilder: (_, int i) {
                      // print("ListView.separated ${currentQuestion.answers[i].isUserAnswer}");
                      final answer = currentQuestion.answers[i];

                      return GestureDetector(
                        key: Key(i.toString()),
                        onTap:
                            answer.isUserAnswer ? null : () => _selectAnswer(i),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 10,
                            ),
                            // color: !answer.isUserAnswer
                            //     ? Theme.of(context)
                            //         .colorScheme
                            //         .primary
                            //         .withOpacity(0.5)
                            //     : Theme.of(context).colorScheme.primary,
                            color: (() {
                              if (answer.isUserAnswer && !answer.isRight) {
                                return Colors.red;
                              } else if (answer.isUserAnswer &&
                                  answer.isRight) {
                                return Colors.green;
                              } else {
                                return Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.5);
                              }
                            })(),
                            child: Text(
                              answer.text,
                              style: TextStyle(
                                color: Theme.of(context).colorScheme.onPrimary,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .headline6!
                                    .fontSize,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              ExpandedElevatedButton(
                text: isCurrentQuestionLast ? "Results" : "Next question",
                onPressed: () => _nextQuestion(isCurrentQuestionLast),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
