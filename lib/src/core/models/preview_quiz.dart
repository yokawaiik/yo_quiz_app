import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yo_quiz_app/src/core/enums/scope.dart';

class PreviewQuiz {
  late final String id;

  late final Timestamp created;
  late final String createdByUser;
  late final String title;
  late final String description;
  late final int questionCount;
  late final String? quizImage;
  late final Scope scope;
  late final bool timer;

  late final String? quizImageRef;

  late final bool isUserOwnQuiz;

PreviewQuiz.fromDoc(uid, QueryDocumentSnapshot<Map<String, dynamic>> doc) {
    id = doc.id;

    final data = doc.data();

    created = data["created"];
    createdByUser = data["createdByUser"];
    title = data["title"];
    description = data["description"];
    questionCount = data["questionCount"];
    

    scope = Scopes.fromString(data["scope"]);
    timer = data["timer"];

    quizImage = data["quizImage"];
    quizImageRef = data["quizImageRef"];

    isUserOwnQuiz = (uid == createdByUser);
    
  }
}
