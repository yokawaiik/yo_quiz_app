import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yo_quiz_app/src/modules/create/enums/scope.dart';
import 'package:yo_quiz_app/src/modules/create/models/question.dart';

class Quiz {
  late final Timestamp created;
  late final String createdByUser;
  late int questionCount;
  late Scope scope;
  late bool timer;

  late List<Question>? questions;

  Quiz({
    required this.createdByUser,
    required this.questionCount,
    required this.scope,
    
    this.questions,
    this.timer = false,
    created,
  }) {
    this.created = Timestamp.now();
  }

  

}
