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

  void startQuiz() {
    _currentQuestion = 1;
  }
  void closeQuiz() {
    _quizPlay = null;
    _currentQuestion = null;
  }

  int? get currentQuestion => _currentQuestion;

  void nextQuestion() {
    if (_currentQuestion! < _quizPlay!.questionCount) {
      _currentQuestion = _currentQuestion! + 1;
    }
  }



  // Stream<QuizPlay?> get quizPlay {
  //   if (_quizPlay == null) {
  //     return Stream.value(null);
  //   } else {
  //     return Stream.value(_quizPlay!);
  //   }
  // }

  Future<QuizPlay?> loadQuiz(String id) async {
    try {
      final snapshot = await _db.collection("quizzes").doc(id).get();

      _quizPlay = QuizPlay.fromDoc(snapshot);

      return _quizPlay;
    } on FirebaseException catch (e) {
      var message = "Firebase db error.";

      throw ApiException(message);
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }


}
