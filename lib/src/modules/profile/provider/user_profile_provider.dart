import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:yo_quiz_app/src/core/models/api_exception.dart';
import 'package:yo_quiz_app/src/core/models/unknown_exception.dart';
import 'package:yo_quiz_app/src/modules/profile/models/user_profile.dart';

class UserProfileProvider {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  Future<UserProfile> loadUserProfile([String? inputUid]) async {
    try {
      late final String uid;
      if (inputUid == null) {
        uid = _auth.currentUser!.uid;
      } else {
        uid = inputUid;
      }

      final snapshot = await _db.collection("users").doc(uid).get();
      final userProfile = UserProfile.fromDoc(snapshot, _auth.currentUser!.uid);

      return userProfile;
    } on FirebaseException catch (e) {
      var message = "Firebase db error.";

      throw ApiException(message);
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  Stream<UserProfile?> userProfile([String? inputUid]) {
    late final String uid;
    if (inputUid == null) {
      uid = _auth.currentUser!.uid;
    } else {
      uid = inputUid;
    }

    return _db.collection("users").doc(uid).snapshots().map((doc) {
      if (!doc.exists) {
        return null;
      } else {
        return UserProfile.fromDoc(doc, _auth.currentUser!.uid);
      }
    });
  }

  Future<void> setProfileImage(File avatarFile) async {
    try {
      final uid = _auth.currentUser!.uid;

      final task = await _storage
          .ref()
          .child("users")
          .child(uid)
          .child("avatar.jpg")
          .putFile(avatarFile);

      final avatarURL = await task.ref.getDownloadURL();

       _db.collection("users").doc(uid).update({"avatar": avatarURL});

       _auth.currentUser!.updatePhotoURL(avatarURL);
    } on FirebaseException catch (e) {
      var message = "Firebase db error.";

      throw ApiException(message);
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }
}
