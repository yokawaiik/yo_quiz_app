import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:yo_quiz_app/firebase_options.dart';
import 'package:yo_quiz_app/src/app_quiz.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AppQuiz());
}
