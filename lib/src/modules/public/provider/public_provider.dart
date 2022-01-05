import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yo_quiz_app/src/core/enums/scope.dart';
import 'package:yo_quiz_app/src/core/models/preview_quiz.dart';

class PublicProvider {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Stream<List<PreviewQuiz>> get quizzes {
    return _db
        .collection("quizzes")
        .where("scope", isEqualTo: Scope.private.name)
        .snapshots()
        .map((snapshots) => snapshots.docs
            .map((doc) => PreviewQuiz.fromDoc(_auth.currentUser!.uid, doc))
            .toList());
  }
}
