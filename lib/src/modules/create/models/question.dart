import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yo_quiz_app/src/modules/create/models/answer.dart';

class Question {
  // for edit
  late final String id;

  late String question;
  late List<Answer> answers;
  late int? secondsInTimer;

  late bool timer;

  // mark editted
  late bool isEditted;

  Question({
    required this.id,
    required this.question,
    required this.answers,
    this.timer = false,
    this.secondsInTimer,
    this.isEditted = false,
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

    isEditted = false;

    final fieldOfAnswers = data["answers"] as List<dynamic>;

    answers = fieldOfAnswers.map((answer) => Answer.fromMap(answer)).toList();
  }

  Map<String, Object?> toMap() {
    int rightAnswers = 0;

    for (var answer in answers) {
      if (answer.isRight) rightAnswers += 1;
    }

    return {
      "question": question,
      "answers": answersToListOfMap(),
      "secondsInTimer": secondsInTimer,
      "timer": timer,
      "rightAnswers": rightAnswers,
    };
  }
}
