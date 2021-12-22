
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yo_quiz_app/src/core/models/api_exception.dart';
import 'package:yo_quiz_app/src/core/models/unknown_exception.dart';
import 'package:yo_quiz_app/src/modules/profile/models/user_profile.dart';

class UserProfileProvider {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Future<UserProfile> loadUserProfile([String? inputUid]) async {
    try {
      late final String uid;
      if (inputUid == null) {
        uid = _auth.currentUser!.uid;
      } else {
        uid = inputUid;
      }

      final snapshot = await _db.collection("users").doc(uid).get();
      final userProfile = UserProfile.fromDoc(snapshot, uid);

      return userProfile;
    } on FirebaseException catch (e) {
      var message = "Firebase db error.";

      throw ApiException(message);
    } catch (e) {
      throw UnknownException(e.toString());
    }

  }


}