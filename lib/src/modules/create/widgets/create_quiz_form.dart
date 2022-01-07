import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yo_quiz_app/src/modules/create/provider/create_quiz_provider.dart';
import 'package:yo_quiz_app/src/modules/create/provider/create_quiz_provider.dart';
import 'package:yo_quiz_app/src/modules/create/provider/ui_quiz_create_provider.dart';
import 'package:yo_quiz_app/src/modules/create/widgets/quiz_action_button.dart';

class CreateQuizForm extends StatelessWidget {
  // Function
  final GlobalKey<FormState> form;
  CreateQuizForm({
    Key? key,
    required this.form,
  }) : super(key: key);

 
  @override
  Widget build(BuildContext context) {
    final uIQuizCreateProvider =
        Provider.of<UIQuizCreateProvider>(context, listen: true);

    return Form(
      key: form,

      child: Column(
        children: [
          TextFormField(
            // initialValue: createQuizProvider.title,
            initialValue: uIQuizCreateProvider.title,
            decoration: InputDecoration(
              labelText: "Title",
            ),
            onChanged: (v) {
              // createQuizProvider.title = v;
              uIQuizCreateProvider.title = v;
            },
            validator: (v) {
              if (v == null || v.isEmpty) return "Field can not empty.";
              if (v.length < 5 && v.length > 100)
                return "Field can not more 100 and less 5 letters.";

              return null;
            },
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            // initialValue: createQuizProvider.description,
            initialValue: uIQuizCreateProvider.description,
            onChanged: (v) {
              // createQuizProvider.description = v;
              uIQuizCreateProvider.description = v;
            },
            minLines: 1,
            maxLines: 10,
            decoration: InputDecoration(labelText: "Description"),
            validator: (v) {
              if (v == null || v.isEmpty) return "Field can not empty.";
              if (v.length < 5 || v.length > 200)
                return "Field can not more 200 and less 5 letters.";

              return null;
            },
          ),
        ],
      ),
    );
  }
}
