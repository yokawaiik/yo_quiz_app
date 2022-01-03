import 'package:cloud_firestore/cloud_firestore.dart';

class GameResults {
  late final int rightAnswers;
  late final int wrongAnswers;
  late final int notAnswered;
  late final int totalAnswers;
  late final int rating;

  late final Timestamp timestamp;


  GameResults({
    required this.rightAnswers,
    required this.wrongAnswers,
    required this.notAnswered,
    required this.totalAnswers,
    required this.timestamp,
    required this.rating,
    
  });
}
