import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:yo_quiz_app/src/modules/quiz/models/game_question.dart';

class GameQuiz {
  late final String id;
  late final String title;
  late final String description;
  late final int questionCount;
  late final String created;

  late final String? quizImage;

  late final List<GameQuestion> questions;
  //Scope scope;
  //bool timer;

  GameQuiz({
    required this.id,
    required this.title,
    required this.description,
    required this.questionCount,
    required this.created,
    required this.quizImage,
    required this.questions,
  });

  GameQuiz.fromDoc(
    DocumentSnapshot<Map<String, dynamic>> docQuiz,
    QuerySnapshot<Map<String, dynamic>> docQuestions,
  ) {
    id = docQuiz.id;
    final data = docQuiz.data()!;

    title = data["title"];
    description = data["description"];
    questionCount = data["questionCount"];
    created = DateFormat("MM/dd/yyyy").format(
        DateTime.fromMillisecondsSinceEpoch(
            (data["created"] as Timestamp).millisecondsSinceEpoch));
    quizImage = data["quizImage"];

    questions =
        docQuestions.docs.map((doc) => GameQuestion.fromDoc(doc)).toList();

  }

  void clearAnswers() {
    print(" GameQuiz clearUserAnswers");
    
    for (var question in questions) {
      question.clearSelectAnswers();
    }
  }
}
