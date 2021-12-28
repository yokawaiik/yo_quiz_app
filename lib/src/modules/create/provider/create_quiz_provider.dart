
import 'package:flutter/material.dart';
import 'package:yo_quiz_app/src/modules/create/models/question.dart';

class CreateQuizProvider extends ChangeNotifier {
  List<Question> _questions = [];

  List<Question> get questions => [..._questions];

  // create

  void addQuestion(Question question) async {
    
    _questions.add(question);
    notifyListeners();
  }

  // void editQuestion(Question editedQuestion) async {
    // Todo:
  void editQuestion(Question editedQuestion) {

    final index = _questions.indexWhere((question) => question.id == editedQuestion.id);

    _questions[index] = editedQuestion;
    notifyListeners();
  }

  void removeQuestion(String id) {
    _questions.removeWhere((item) => item.id == id);
    notifyListeners();
  }


  Future<void> loadQuiz() async {
    // Todo: load quiz for edit its
  }

  Question loadQuestion(String id) {
    // Todo: load question for edit its
    final question =
        _questions.firstWhere((Question question) => question.id == id);

    return question;
  }

  // cancel

  void cancelCreateQuiz() {
    // Todo: clearing all data
  }
}
