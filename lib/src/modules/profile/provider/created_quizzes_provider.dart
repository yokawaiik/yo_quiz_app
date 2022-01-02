import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yo_quiz_app/src/modules/profile/models/created_quiz.dart';

class CreatedQuizzesProvider {
  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Stream<List<CreatedQuiz>> createdQuizzes(String uid) {
    return _db.collection("quizzes")
    .where("createdByUser", isEqualTo: uid).snapshots()
    .map((snapshot) => snapshot.docs.map(
      (doc) {
        // print(doc.id);
        return CreatedQuiz.fromDoc(doc);
        }
      ).toList());
  }

}
