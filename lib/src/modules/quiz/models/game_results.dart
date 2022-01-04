import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class GameResults {
  late final int rightAnswers;
  late final int wrongAnswers;
  late final int notAnswered;
  late final int totalAnswers;
  late final int rating;

  late final Timestamp timestamp;


  String get date {
    return DateFormat("D/M/yyyy HH:mm").format(DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch));
  }

  GameResults({
    required this.rightAnswers,
    required this.wrongAnswers,
    required this.notAnswered,
    required this.totalAnswers,
    required this.timestamp,
    required this.rating,
    
  });
}
