import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:yo_quiz_app/src/core/models/api_exception.dart';
import 'package:yo_quiz_app/src/core/models/unknown_exception.dart';
import 'package:yo_quiz_app/src/modules/create/models/question.dart';
import 'package:yo_quiz_app/src/modules/create/models/quiz.dart';

class CreateQuizProvider extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  final _firebaseStorage = FirebaseStorage.instance;

  List<Question> _questions = [];

  List<Question> get questions => [..._questions];

  // create

  Future<void> createQuiz(Quiz quiz) async {
    try {
      // create quiz doc
      final quizCredential = await _db.collection("quizzes").add({
        "title": quiz.title!,
        "description": quiz.description!,
        "created": quiz.created,
        "createdByUser": _auth.currentUser!.uid,
        "questionCount": _questions.length,
        "scope": quiz.scope.name,
        "timer": quiz.timer,
        "quizImage": null,
      });

      if (quiz.quizImage != null) {
        final uploadTask = await _firebaseStorage
            .ref()
            .child("quizzes")
            .child("quizImage")
            .child("${quizCredential.id}.jpg")
            .putFile(quiz.quizImage!);

        final quizImagePath = await _firebaseStorage
            .ref(uploadTask.ref.fullPath)
            .getDownloadURL();

        await _db.collection("quizzes").doc(quizCredential.id).update({
          "quizImage": quizImagePath,
        });
      }

      // create quiz nested collection "questions"

      for (var item in _questions) {
        await _db
            .collection("quizzes")
            .doc(quizCredential.id)
            .collection("questions")
            .doc(item.id)
            .set({
          "question": item.question,
          "secondsInTimer": item.secondsInTimer,
          "timer": item.questionHasTimer,
          "answers": item.answersToListOfMap(),
        });
      }
    } on FirebaseException catch (e) {
      var message = "Database error";

      throw ApiException(message);
    } catch (e) {
      print("createQuiz $e");

      throw UnknownException(e.toString());
    }
  }

  void addQuestion(Question question) async {
    _questions.add(question);
    notifyListeners();
  }

  // void editQuestion(Question editedQuestion) async {
  // Todo:
  void editQuestion(Question editedQuestion) {
    final index =
        _questions.indexWhere((question) => question.id == editedQuestion.id);

    _questions[index] = editedQuestion;
    notifyListeners();
  }

  void removeQuestion(String id) {
    _questions.removeWhere((item) => item.id == id);
    notifyListeners();
  }

  Future<void> loadQuiz() async {
    // Todo: load quiz for edit its
  }

  Question loadQuestion(String id) {
    // Todo: load question for edit its
    final question =
        _questions.firstWhere((Question question) => question.id == id);

    return question;
  }

  // cancel

  void cancelCreateQuiz() {
    // Todo: clearing all data

    _questions.clear();
  }
}
