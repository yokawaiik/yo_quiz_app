import 'package:cloud_firestore/cloud_firestore.dart';

class GameResults {
  late final int rightAnswers;
  late final int wrongAnswers;
  late final int notAnswered;
  late final int totalQuestions;

  late final Timestamp timestamp;

  GameResults({
    required this.rightAnswers,
    required this.wrongAnswers,
    required this.notAnswered,
    required this.totalQuestions,
    required this.timestamp,
  });
}
