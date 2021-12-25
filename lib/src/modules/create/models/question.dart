import 'package:yo_quiz_app/src/modules/create/models/answer.dart';

class Question {
  // for edit
  late final String? id;

  late List<Answer> answers;
  late int? secondsInTimer;
  
  Question({

    this.id,
    required this.answers,
    this.secondsInTimer,
    
  });
}