import 'package:flutter/material.dart';

class CreateQuestionsArea extends StatefulWidget {
  static const String routeName = "/create-questions-area";

  const CreateQuestionsArea({Key? key}) : super(key: key);

  @override
  State<CreateQuestionsArea> createState() => _CreateQuestionsAreaState();
}

class _CreateQuestionsAreaState extends State<CreateQuestionsArea> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("CreateQuestionsArea"),),
    );
  }
}
