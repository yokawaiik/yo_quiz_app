import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yo_quiz_app/src/modules/auth/provider/auth_provider.dart';
import 'package:yo_quiz_app/src/modules/auth/screens/auth_screen.dart';
import 'package:yo_quiz_app/src/modules/main/screens/main_screen.dart';

class AuthWrapper extends StatelessWidget {
  static const String routeName = "/auth-wrapper";

  const AuthWrapper({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: Provider.of<AuthProvider>(context).currentUser,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(),);
        } 

        if (snapshot.hasData) {
          return MainScreen();
        } else {
          return AuthScreen();
        }
      },
    );
  }
}