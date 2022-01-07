import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yo_quiz_app/src/core/enums/scope.dart';
import 'package:yo_quiz_app/src/modules/create/models/question.dart';

class Quiz {
  String? id;

  late final Timestamp? created;
  late final String? createdByUser;
  late int? questionCount;
  late Scope scope;


  late String? quizImageRef;

  

  late bool timer;

  late List<Question>? questions;
  late String? title;
  late String? description;

  Quiz({
    this.id,
    this.createdByUser,
    this.questionCount,
    this.scope = Scope.private,
    this.description,
    this.quizImageRef,
    this.questions,
    this.title,
    this.timer = false,
    this.created,
  });

  Quiz.fromDoc(
    DocumentSnapshot<Map<String, dynamic>> quizDoc,
    QuerySnapshot<Map<String, dynamic>> questionsSnapshot,
  ) {
    id = quizDoc.id;
    final dataQuiz = quizDoc.data()!;
    created = dataQuiz["created"];
    createdByUser = dataQuiz["createdByUser"];
    questionCount = dataQuiz["questionCount"];
    scope = Scopes.fromString(dataQuiz["scope"]);

    // print("dataQuiz[\"timer\"]: ${dataQuiz["timer"]}");
    timer = dataQuiz["timer"];
    title = dataQuiz["title"];
    description = dataQuiz["description"];



    print("load");

    questions =
        questionsSnapshot.docs.map((doc) => Question.fromDoc(doc)).toList();


    // ! error
        // todo: load on string ref
    // quizImage = dataQuiz["quizImage"];

    quizImageRef = dataQuiz["quizImageRef"];
  }

  Quiz copyWith() {
    return Quiz(
      id: id,
      created: created,
      createdByUser: createdByUser,
      questionCount: questionCount,
      scope: scope,
      description: description,
      quizImageRef: quizImageRef,
      questions: [...?questions],
      title: title,
      timer: timer,
    );
  }

  // todo: load image
  // Future<File> loadImage() async {
    
  // }
}
