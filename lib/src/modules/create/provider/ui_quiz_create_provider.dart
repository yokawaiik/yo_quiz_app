import 'package:flutter/material.dart';
import 'package:yo_quiz_app/src/modules/create/models/question.dart';
import 'package:yo_quiz_app/src/modules/create/provider/create_quiz_provider.dart';
import 'package:yo_quiz_app/src/modules/create/screens/create_questions_area_screen.dart';

class UIQuizCreateProvider extends ChangeNotifier {
  UIQuizCreateProvider({required this.createQuizProvider});

  bool isQuizUpload = false;

  String? title;
  String? description;

  bool get isQuizEdit {
    return createQuizProvider.quiz.id != null;
  }

  CreateQuizProvider createQuizProvider;

  update(CreateQuizProvider createQuizProvider) {
    print("update");
    createQuizProvider = createQuizProvider;
  }

  Future<void>? updateQuiz(BuildContext context) async {
    isQuizUpload = true;
    notifyListeners();
    print("updateQuiz");

    createQuizProvider.title = title;
    createQuizProvider.description = description;

    await createQuizProvider.updateQuiz();

    notifyListeners();
    isQuizUpload = false;
    closeCreateQuiz(context);
  }

  Future<void>? createQuiz(BuildContext context) async {
    isQuizUpload = true;
    notifyListeners();
    print("createQuiz");

    createQuizProvider.title = title;
    createQuizProvider.description = description;

    await createQuizProvider.createQuiz();

    notifyListeners();
    isQuizUpload = false;

    closeCreateQuiz(context);
  }

  Future<void> editQuestion(Question editedQuestion) async {

    await createQuizProvider.editQuestion(editedQuestion);

    notifyListeners();
  }

  Future<void> removeQuestion(String id) async {
    await createQuizProvider.removeQuestion(id);

    notifyListeners();
  }

  Future<void> addQuestion(Question question) async {
    

    await createQuizProvider.createQuestion(question);

    notifyListeners();
  }

  void closeCreateQuiz(context) {
    print("closeCreateQuiz");
    Navigator.of(context).pop();

    createQuizProvider.cancelCreateQuiz();
    title = null;
    description = null;

    // isQuizEdit = false;
    isQuizUpload = false;
  }

  bool isQuizInfoValid(GlobalKey<FormState> form) {
    if (!form.currentState!.validate()) return false;

    form.currentState!.save();
    return true;
  }

  void goToCreateQuestionsArea(
      BuildContext context, GlobalKey<FormState> form) {
    if (!isQuizInfoValid(form)) return;

    FocusScope.of(context).unfocus();
    Navigator.of(context).pushNamed(CreateQuestionsAreaScreen.routeName);
  }

  // todo
  Future<void> loadQuizToEdit(BuildContext context, String id) async {
    print("loadQuizToEdit");
    try {
      // isQuizEdit = true;

      await createQuizProvider.loadQuizToEdit(id);

      print("createQuizProvider.quiz.id ${createQuizProvider.quiz.id}");
      title = createQuizProvider.title;
      description = createQuizProvider.description;
    } catch (e) {
      print("_loadQuizToEdit: $e");
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Quiz error.",
          ),
        ),
      );
    }
  }



}
