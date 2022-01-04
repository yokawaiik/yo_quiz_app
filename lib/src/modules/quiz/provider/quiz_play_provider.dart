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

  GameResults? _gameResults;

  int? _currentQuestionIndex;
  // todo: add model for answer (userAnswer)

  GameResults? get gameResults => _gameResults;

  int? get currentQuestionIndex => _currentQuestionIndex;

  GameQuiz? get quizPlay => _quizPlay;

  GameQuestion? get currentQuestion {
    if (_quizPlay == null) return null;
    return _quizPlay!.questions[_currentQuestionIndex!];
  }

  bool? get isCurrentQuestionLast {
    if (_quizPlay == null) return null;
    return (_currentQuestionIndex! == _quizPlay!.questions.length - 1);
  }

  void startQuiz() {
    _currentQuestionIndex = 0;
  }

  void closeQuiz() {
    _quizPlay!.clearAnswers();
    _currentQuestionIndex = null;
  }

  void nextQuestion() {
    print(_quizPlay!.questionCount);

    if (!isCurrentQuestionLast!) {
      _currentQuestionIndex = _currentQuestionIndex! + 1;
    }
    notifyListeners();
  }

  void selectAnswer(int index) {
    // print("selectAnswer index $index");

    final currentQuestion = _quizPlay!.questions[_currentQuestionIndex!];

    if (currentQuestion.attemptAnswers! > 0) {

      currentQuestion.answers[index].toggleSelect();
      currentQuestion.removeAttempt();

      notifyListeners();
    }
    
  }

  Future<GameQuiz?> loadQuiz(String id) async {
    print("loadQuiz");
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
      int totalAnswers = 0;

      int rightAnswers = 0;
      int wrongAnswers = 0;
      int notAnswered = 0;

      for (var question in _quizPlay!.questions) {
        for (var answer in question.answers) {
          if (answer.isRight) {
            totalAnswers++;
          }
          print("${answer.isRight},  ${answer.isUserAnswer}");
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
      int rating;
      print("rightAnswers $rightAnswers");
      if (rightAnswers.isNaN || rightAnswers.isInfinite || rightAnswers == 0) {
        rating = 0;
      } else {
        rating = ((rightAnswers / totalAnswers) * 100).toInt();
      }

      _gameResults = GameResults(
        rightAnswers: rightAnswers,
        wrongAnswers: wrongAnswers,
        notAnswered: notAnswered,
        totalAnswers: totalAnswers,
        rating: rating,
        timestamp: Timestamp.now(),
      );

      return _gameResults!;
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }
}
