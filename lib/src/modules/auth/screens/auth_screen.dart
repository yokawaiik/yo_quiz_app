import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  static const String routeName = "auth";

  AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(),
    );
  }
}