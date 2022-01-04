import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yo_quiz_app/src/modules/create/enums/scope.dart';
import 'package:yo_quiz_app/src/modules/create/models/question.dart';

class Quiz {
  late final Timestamp created;
  late final String? createdByUser;
  late int? questionCount;
  late Scope scope;
  late File? quizImage;

  late bool timer;

  late List<Question>? questions;
  late String? title;
  late String? description;

  Quiz({
    this.createdByUser,
    this.questionCount,
    this.scope = Scope.private,
    this.description,
    this.quizImage,
    this.questions,
    this.title,
    this.timer = false,
  }) {
    created = Timestamp.now();
  }
}
