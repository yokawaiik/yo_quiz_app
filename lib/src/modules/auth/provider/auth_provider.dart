import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:yo_quiz_app/src/core/models/api_exception.dart';
import 'package:yo_quiz_app/src/core/models/unknown_exception.dart';

import 'package:yo_quiz_app/src/modules/auth/models/auth_form_user.dart';

class AuthProvider {
  final _auth = FirebaseAuth.instance;
  final _db = FirebaseFirestore.instance;

  Stream<User?> get currentUser {
    return _auth.authStateChanges().map((User? user) {
      if (user == null) {
        return null;
      } else {
        return user;
      }
    });
  }

  Future<void> signUpWithWithEmailAndPassword(AuthFormUser authFormUser) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: authFormUser.email!,
        password: authFormUser.password!,
      );

      await _auth.currentUser!.updateDisplayName(authFormUser.login);

      await _db.collection("users").doc(userCredential.user!.uid).set({
        "login": authFormUser.login,
        "email": authFormUser.email,
        "fullName": authFormUser.fullName,
      });

    } on FirebaseAuthException catch (e) {
      var message = "Firebase error";

      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      }

      throw ApiException(message);
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  Future<void> signInWithEmailAndPassword(AuthFormUser authFormUser) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: authFormUser.email!,
        password: authFormUser.password!,
      );
    } on FirebaseAuthException catch (e) {
      var message = "Firebase error";

      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
      }

      throw ApiException(message);
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
  
    } on FirebaseAuthException catch (e) {
      var message = "Firebase error";

      if (e.code == 'requires-recent-login') {
        message =
            'The user must reauthenticate before this operation can be executed.';
      }

      throw ApiException(message);
    } catch (e) {
      throw UnknownException(e.toString());
    }
  }
}
