import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yo_quiz_app/src/modules/quiz/models/game_answer.dart';

class GameQuestion {
  late final String id;
  late final String question;
  late List<GameAnswer> answers;
  late final bool? timer;
  late final int? secondsInTimer;

  GameQuestion({
    required this.question,
    required this.answers,
    required this.timer,
    required this.secondsInTimer,
  });

  GameQuestion.fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    id = doc.id;
    final data = doc.data();
    question = data["question"];
    timer = data["timer"];
    secondsInTimer = data["secondsInTimer"];

    answers = (data["answers"] as List<dynamic>)
        .map((item) => GameAnswer.fromListOfMap(item))
        .toList();
  }
}
