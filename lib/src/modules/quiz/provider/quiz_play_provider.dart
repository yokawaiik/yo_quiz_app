import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:yo_quiz_app/src/core/models/api_exception.dart';
import 'package:yo_quiz_app/src/modules/create/models/question.dart';
import 'package:yo_quiz_app/src/modules/quiz/models/game_question.dart';
import 'package:yo_quiz_app/src/modules/quiz/models/game_quiz.dart';
import 'package:yo_quiz_app/src/core/models/unknown_exception.dart';
import 'package:yo_quiz_app/src/modules/quiz/models/game_results.dart';

class QuizPlayProvider extends ChangeNotifier {
  final _db = FirebaseFirestore.instance;
  GameQuiz? _quizPlay;

  int? _currentQuestionIndex;
  // todo: add model for answer (userAnswer)

  void startQuiz() {
    _currentQuestionIndex = 0;
  }

  void closeQuiz() {
    _quizPlay = null;
    _currentQuestionIndex = null;
  }

  int? get currentQuestionIndex => _currentQuestionIndex;

  GameQuiz? get quizPlay => _quizPlay;

  GameQuestion? get currentQuestion {
    if (_quizPlay == null) return null;
    return _quizPlay!.questions[_currentQuestionIndex!];
  }

  bool? get isCurrentQuestionLast {
    if (currentQuestion == null) return null;
    return (_currentQuestionIndex! == _quizPlay!.questions.length - 1);
  }

  void nextQuestion() {
    print(_quizPlay!.questionCount);

    if (!isCurrentQuestionLast!) {
      _currentQuestionIndex = _currentQuestionIndex! + 1;
    }
    notifyListeners();
  }

  void selectAnswer(int index) {
    print("selectAnswer index $index");
    final answer = _quizPlay!.questions[_currentQuestionIndex!].answers[index];
    answer.toggleSelect();

    // print("selectAnswer ${answer.isUserAnswer}");

    notifyListeners();
  }

  Future<GameQuiz?> loadQuiz(String id) async {
    try {
      final snapshotQuiz = await _db.collection("quizzes").doc(id).get();

      final snapshotQuestions =
          await _db.collection("quizzes").doc(id).collection("questions").get();

      _quizPlay = GameQuiz.fromDoc(snapshotQuiz, snapshotQuestions);

      return _quizPlay;
    } on FirebaseException catch (e) {
      var message = "Firebase db error.";

      throw ApiException(message);
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  Future<GameResults> finishQuiz() async {
    try {
      

      final int totalQuestions = _quizPlay!.questions.length;

      int rightAnswers = 0;
      int wrongAnswers = 0;
      int notAnswered = 0;

      for (var question in _quizPlay!.questions) {
        for (var answer in question.answers) {
          if (answer.isRight && answer.isUserAnswer) {
            rightAnswers++;
          } else if (!answer.isRight && answer.isUserAnswer) {
            wrongAnswers++;
          
          } else if (answer.isRight && !answer.isUserAnswer) {
            notAnswered++;
          }
          
        }
      }
      // todo: write to _db

      return GameResults(
        rightAnswers: rightAnswers,
        wrongAnswers: wrongAnswers,
        notAnswered: notAnswered,
        totalQuestions: totalQuestions,
        
        timestamp: Timestamp.now(),
      );
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }
}
