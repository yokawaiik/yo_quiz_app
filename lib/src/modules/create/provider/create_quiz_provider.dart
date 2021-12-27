import 'package:yo_quiz_app/src/modules/create/models/question.dart';

class CreateQuizProvider {
  List<Question> _questions = [];



  List<Question> get questions => [..._questions];



  // create

  Future<void> createQuestion() async {
    // Todo:
  }



  Future<void> loadQuiz() async {
    // Todo: load quiz for edit its
  }

  // return Question
  void loadQeustion() async {
    // Todo: load question for edit its
  }


  // cancel

  void cancelCreateQuiz() {
    // Todo: clearing all data
  }
}
