import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yo_quiz_app/src/core/models/api_exception.dart';
import 'package:yo_quiz_app/src/core/models/quiz_play.dart';
import 'package:yo_quiz_app/src/core/models/unknown_exception.dart';

class QuizPlayProvider {
  final _db = FirebaseFirestore.instance;
  QuizPlay? _quizPlay;

  int? _currentQuestion;
  // todo: add model for answer (userAnswer)

  Stream<QuizPlay>? get quizPlay {
    if (_quizPlay == null) {
      return null;
    } else {
      return Stream.value(_quizPlay!);
    }
  }

  Future<void> loadQuiz(String id) async {
    try {
      final snapshot = await _db.collection("quizzes").doc(id).get();

      _quizPlay = QuizPlay.fromDoc(snapshot);


    } on FirebaseException catch (e) {
      var message = "Firebase db error.";

      throw ApiException(message);
    } catch (e) {
      throw UnknownException(e.toString());
    }


  }
}