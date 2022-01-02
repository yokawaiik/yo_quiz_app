import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:yo_quiz_app/src/modules/auth/screens/auth_wrapper_screen.dart';
import 'package:yo_quiz_app/src/modules/create/models/quiz.dart';
import 'package:yo_quiz_app/src/modules/create/provider/create_quiz_provider.dart';
import 'package:yo_quiz_app/src/modules/create/screens/create_questions_area_screen.dart';
import 'package:yo_quiz_app/src/modules/profile/screens/created_quizzes_screen.dart';

class CreateQuizScreen extends StatefulWidget {
  static const String routeName = "/create-quiz-screen";

  CreateQuizScreen({Key? key}) : super(key: key);

  @override
  _CreateQuizScreenState createState() => _CreateQuizScreenState();
}

class _CreateQuizScreenState extends State<CreateQuizScreen> {
  late bool _isQuizCreate;

  // late bool _quizHasTimer;
  // File? _quizImage;

  late final Quiz _quiz;

  late final GlobalKey<FormState> _form;

  @override
  void initState() {
    super.initState();

    _isQuizCreate = false;
    // _quizHasTimer = false;
    _quiz = Quiz();
    _form = GlobalKey<FormState>();
  }

  Future<void> _addQuizImage() async {
    final picker = ImagePicker();

    final imagePicked =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (imagePicked == null) return;

    setState(() {
      _quiz.quizImage = File(imagePicked.path);
    });
  }

  void _goToCreateQuestionsArea() {
    final isFormValid = _form.currentState!.validate();
    print(isFormValid);

    if (!isFormValid) return;

    _form.currentState!.save();
    // todo: save data in provider

    FocusScope.of(context).unfocus();
    Navigator.of(context).pushNamed(CreateQuestionsAreaScreen.routeName);
  }

  void _closeCreateQuiz() {
    Navigator.pushReplacementNamed(context, AuthWrapper.routeName);
    Provider.of<CreateQuizProvider>(context, listen: false).cancelCreateQuiz();
  }

  void _createQuiz() async {
    // todo:
    try {
      setState(() {
        _isQuizCreate = true;
      });

      await Provider.of<CreateQuizProvider>(context, listen: false)
          .createQuiz(_quiz);

      // clear Navigator and go to home screen
      await Navigator.of(context).pushNamedAndRemoveUntil(
        AuthWrapper.routeName,
        (route) => false,
      );

      await Navigator.of(context).pushNamed(CreatedQuizzesScreen.routeName);

    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
    setState(() {
      _isQuizCreate = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final device = MediaQuery.of(context).size;

    final isQuestionsEmpty =
        Provider.of<CreateQuizProvider>(context).questions.isEmpty;

    return WillPopScope(
      onWillPop: () async {
        _closeCreateQuiz();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.primary,
          actions: [
            IconButton(
              onPressed: _closeCreateQuiz,
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
                padding: const EdgeInsets.only(
                  right: 16.0,
                  left: 16.0,
                  bottom: 16.0,
                ),
                child: Form(
                  key: _form,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Image for your quiz"),
                          SizedBox(
                            height: 10,
                          ),
                          // Todo: add image
                          GestureDetector(
                            onTap: () {
                              _addQuizImage();
                            },
                            child: SizedBox(
                              height: device.height * (2 / 7),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: _quiz.quizImage != null
                                    ? Image.file(
                                        _quiz.quizImage!,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                      )
                                    : Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.image,
                                            size: 100,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                          ),
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: InputDecoration(labelText: "Title"),
                            onChanged: (v) {
                              _quiz.title = v;
                            },
                            validator: (v) {
                              if (v == null || v.isEmpty)
                                return "Field can not empty.";
                              if (v.length < 5 && v.length > 100)
                                return "Field can not more 100 and less 5 letters.";

                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            initialValue: _quiz.description,
                            onChanged: (v) {
                              _quiz.description = v;
                            },
                            minLines: 1,
                            maxLines: 10,
                            decoration:
                                InputDecoration(labelText: "Description"),
                            validator: (v) {
                              if (v == null || v.isEmpty)
                                return "Field can not empty.";
                              if (v.length < 5 || v.length > 200)
                                return "Field can not more 200 and less 5 letters.";

                              return null;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),

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
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: isQuestionsEmpty
                            ? OutlinedButton(
                                onPressed: _goToCreateQuestionsArea,
                                child: Text("Create questions"),
                              )
                            : ElevatedButton(
                                onPressed: !_isQuizCreate ? _createQuiz : null,
                                child: !_isQuizCreate
                                    ? Text("Create quiz")
                                    : Center(
                                        child: CircularProgressIndicator(),
                                      ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
