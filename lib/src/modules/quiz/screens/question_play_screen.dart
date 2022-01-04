import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yo_quiz_app/src/core/widgets/transparent_app_bar.dart';
import 'package:yo_quiz_app/src/modules/quiz/provider/quiz_play_provider.dart';
import 'package:yo_quiz_app/src/modules/quiz/screens/quiz_main_screen.dart';
import 'package:yo_quiz_app/src/modules/quiz/screens/quiz_results_screen.dart';
import 'package:yo_quiz_app/src/modules/quiz/widgets/answers_area.dart';
import 'package:yo_quiz_app/src/modules/quiz/widgets/expanded_elevated_button.dart';
import 'package:yo_quiz_app/src/modules/quiz/widgets/question_area.dart';
import 'package:yo_quiz_app/src/modules/quiz/widgets/question_attempt_counter.dart';

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
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  QuestionAttemptCounter(
                      attemptAnswers: currentQuestion.attemptAnswers!)
                ],
              ),
              QuestionArea(question: currentQuestion.question),
              SizedBox(
                height: 40,
              ),
              AnswersArea(
                answers: currentQuestion.answers,
                selectAnswer: _selectAnswer,
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
                child: ExpandedElevatedButton(
                  text: isCurrentQuestionLast ? "Results" : "Next question",
                  onPressed: () => _nextQuestion(isCurrentQuestionLast),
                ),
              ),
            ],
          ),
        ),
        // floatingActionButton: FloatingActionButton.extended(

        //   onPressed: () => _nextQuestion(isCurrentQuestionLast),
        //   label: Text(isCurrentQuestionLast ? "Results" : "Next question"),
        // ),

        // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
