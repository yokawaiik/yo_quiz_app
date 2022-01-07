import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:yo_quiz_app/src/core/widgets/quiz_image.dart';
import 'package:yo_quiz_app/src/modules/auth/screens/auth_wrapper_screen.dart';
import 'package:yo_quiz_app/src/modules/create/models/quiz.dart';
import 'package:yo_quiz_app/src/modules/create/provider/create_quiz_provider.dart';
import 'package:yo_quiz_app/src/modules/create/screens/create_questions_area_screen.dart';
import 'package:yo_quiz_app/src/modules/create/widgets/create_quiz_form.dart';
import 'package:yo_quiz_app/src/modules/create/widgets/create_quiz_image.dart';
import 'package:yo_quiz_app/src/modules/create/widgets/quiz_action_button.dart';
import 'package:yo_quiz_app/src/modules/profile/screens/created_quizzes_screen.dart';

class CreateQuizScreen extends StatelessWidget {
  static const String routeName = "/create-quiz-screen";

  CreateQuizScreen({Key? key}) : super(key: key);


  late bool _isQuizUpload = false;
  late bool _isQuizEdit = false;

  // late final Quiz _quiz;

  // late final GlobalKey<FormState> _form;



  // @override
  // void initState() {
  //   super.initState();

  //   _isQuizUpload = false;
  //   _isQuizEdit = false;
  //   // _quizHasTimer = false;
  //   // _quiz = Quiz();
    
  // }

  void _goToCreateQuestionsArea() {
    // final isFormValid = _form.currentState!.validate();
    // print(isFormValid);

    // if (!isFormValid) return;

    // _form.currentState!.save();

    // FocusScope.of(context).unfocus();
    // Navigator.of(context).pushNamed(CreateQuestionsAreaScreen.routeName);
  }

  void _closeCreateQuiz(BuildContext context) {
    // Navigator.pushReplacementNamed(context, AuthWrapper.routeName);
    Navigator.of(context).pop();
    Provider.of<CreateQuizProvider>(context, listen: false).cancelCreateQuiz();
  }

  // todo:
  Future<void> _updateQuiz(BuildContext context) async {}

  Future<void> _createQuiz(BuildContext context) async {
    try {
      // setState(() {
      //   _isQuizUpload = true;
      // });

      final createQuizProvider =
          Provider.of<CreateQuizProvider>(context, listen: false);

      // print("_title $_title");
      // print("_description $_description");

      // createQuizProvider.title = _title!;
      // createQuizProvider.description = _description!;

      await createQuizProvider.createQuiz();

      // clear Navigator and go to home screen
      await Navigator.of(context).pushNamedAndRemoveUntil(
        AuthWrapper.routeName,
        (route) => false,
      );

      await Navigator.of(context).pushNamed(CreatedQuizzesScreen.routeName);
      _closeCreateQuiz(context);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    // setState(() {
    //   _isQuizUpload = false;
    // });
  }

  Future<void> _loadQuizToEdit(BuildContext context, String id) async {
    try {
      

      _isQuizEdit = true;

      final createQuizProvider =
          Provider.of<CreateQuizProvider>(context, listen: false);
      await createQuizProvider.loadQuizToEdit(id);



      
    } catch (e) {
      print("_loadQuizToEdit: $e");
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Quiz error.",
          ),
        ),
      );
    }
  }

  

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);



    final id = ModalRoute.of(context)!.settings.arguments as String?;

    // if (id != null) {
    //   print("CreateQuizScreen. id: $id");
    //   _loadQuizToEdit(id);
    // }

    return WillPopScope(
      onWillPop: () async {
        _closeCreateQuiz(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.primary,
          actions: [
            IconButton(
              onPressed: ( )=> _closeCreateQuiz(context),
              icon: Icon(Icons.close),
            ),
            const Spacer(),
            IconButton(
              onPressed: _goToCreateQuestionsArea,
              icon: Icon(Icons.dashboard_customize),
            ),
          ],
          // iconTheme: IconThemeData(color: Colors.white),
          elevation: 0.0,
        ),
        body: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.all(
                  10.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FutureBuilder(
                        future: id == null && _isQuizEdit ? null : _loadQuizToEdit(context, id!),
                        builder: (_, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator(),);
                          }

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Image for your quiz"),
                              SizedBox(
                                height: 10,
                              ),
                              CreateQuizImage(
                                height: mediaQuery.size.height * (2 / 7),
                              ),
                              
                              SizedBox(
                                height: 10,
                              ),
                              // CreateQuizForm(),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          );
                        }),

                    // CheckboxListTile(
                    //   contentPadding: EdgeInsets.all(0),
                    //   controlAffinity: ListTileControlAffinity.leading,
                    //   title: Text("Does Quiz has been timer?"),
                    //   value: _quizHasTimer,
                    //   onChanged: (v) {
                    //     setState(() {
                    //       _quizHasTimer = v!;
                    //     });
                    //   },
                    // )
                    Expanded(child: Container()),
                    // SizedBox(
                    //     width: double.infinity,
                    //     height: 50,
                    //     child: _actionButtonBuilder(isQuestionsEmpty)

                    //     ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
