import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yo_quiz_app/src/modules/create/models/answer.dart';

class Question {
  // for edit
  late final String id;

  late String question;
  late List<Answer> answers;
  late int? secondsInTimer;

  late bool timer;

  Question({
    required this.id,
    required this.question,
    required this.answers,
    this.timer = false,
    this.secondsInTimer,
  });

  List<Map> answersToListOfMap() {
    return answers
        .map((answer) => {
              "text": answer.text,
              "isRight": answer.isRight,
            })
        .toList();
  }

  Question.fromDoc(QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    id = doc.id;

    final data = doc.data();

    question = data["question"];
    secondsInTimer = data["secondsInTimer"];
    timer = data["timer"];

    final fieldOfAnswers = data["answers"] as List<dynamic>;

    answers = fieldOfAnswers
        .map((answer) => Answer.fromMap(answer))
        .toList();
  }
}
