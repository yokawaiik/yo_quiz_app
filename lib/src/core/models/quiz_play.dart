
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class QuizPlay {
  late final String id;
  late final String title;
  late final String description;
  late final int questionCount;
  late final String created;

  late final String? quizImage;
  //Scope scope;
  //bool timer;
  

  QuizPlay({
    required this.id,
    required this.title,
    required this.description,
    required this.questionCount,
    required this.created,
    required this.quizImage,
  });

  QuizPlay.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {

    id = doc.id;
    final data = doc.data()!;

    title = data["title"];
    description = data["description"];
    questionCount = data["questionCount"];
    created = DateFormat("MM/dd/yyyy").format(DateTime
    .fromMillisecondsSinceEpoch((data["created"] as Timestamp).millisecondsSinceEpoch));

    quizImage = data["quizImage"];
  }

  
}
