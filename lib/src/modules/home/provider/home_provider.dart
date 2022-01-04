import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yo_quiz_app/src/core/models/api_exception.dart';
import 'package:yo_quiz_app/src/core/models/unknown_exception.dart';

class HomeProvider {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Future<String> getQuiz(String? id) async {
    try {
      if (id == null) throw ApiException("empty-field");

      final doc = await _db.collection("quizzes").doc(id).get();

      if (doc.exists) {
        return doc.id;
      } else {
        throw ApiException("not-exists");
      }
    } on FirebaseException catch (e) {
      var message = "Database error";
      throw ApiException(message);
    } on ApiException catch (e) {
      var message = "Api error";

      if (e.toString() == "not-exists") {
        message = "Quiz doesn't exists.";
      } else if (e.toString() == "empty-field") {
        message = "Please insert your code";
      }

      throw ApiException(message);
    } catch (e) {
      print("getQuiz $e");
      var message = "Unknown exception";

      throw UnknownException(message);
    }
  }
}
