import 'package:yo_quiz_app/src/modules/create/models/answer.dart';

class Question {
  // for edit
  late final String id;

  late String question;
  late List<Answer> answers;
  late int? secondsInTimer;
  late bool questionHasTimer;
  
  Question({
    required this.id,
    required this.question,
    required this.answers,
    this.questionHasTimer = false,
    this.secondsInTimer,
  });
}