import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yo_quiz_app/src/modules/create/provider/ui_quiz_create_provider.dart';

class QuizActionButton extends StatelessWidget {
  final GlobalKey<FormState> form;
  const QuizActionButton({Key? key, required this.form}) : super(key: key);

  Widget _actionButtonBuilder(
    BuildContext context,
    UIQuizCreateProvider uiQuizCreate,
  ) {
    bool isQuizEdit = uiQuizCreate.isQuizEdit;
    // final isFormValid = uiQuizCreate.isFormValid(form);

    String text;
    Function? handler;
    Widget child;

    if (uiQuizCreate.createQuizProvider.questions.isEmpty) {

      text = "Create questions";

      return OutlinedButton(
        onPressed: () => uiQuizCreate.goToCreateQuestionsArea(context, form),
        child: Text(text),
      );
    } else {
      if (uiQuizCreate.isQuizUpload) {
        child = Center(
          child: CircularProgressIndicator(),
        );
        handler = null;
      } else {
        if (isQuizEdit) {
          text = "Update quiz";
          handler = () {
            if (!uiQuizCreate.isQuizInfoValid(form)) return;
            uiQuizCreate.updateQuiz(context);
          };
        } else {
          text = "Create quiz";
          handler = () {
            if (!uiQuizCreate.isQuizInfoValid(form)) return;
            uiQuizCreate.createQuiz(context);
          };
        }

        child = Text(text);
      }

      return ElevatedButton(
        onPressed: handler == null ? null : () => handler!(),
        child: child,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final uIQuizCreate = Provider.of<UIQuizCreateProvider>(context);

    return SizedBox(
      width: double.infinity,
      height: 50,
      child: _actionButtonBuilder(context, uIQuizCreate),
    );
  }
}
