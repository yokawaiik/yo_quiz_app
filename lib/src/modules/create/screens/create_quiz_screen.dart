import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yo_quiz_app/src/modules/create/provider/create_quiz_provider.dart';
import 'package:yo_quiz_app/src/modules/create/provider/ui_quiz_create_provider.dart';
import 'package:yo_quiz_app/src/modules/create/widgets/create_quiz_form.dart';
import 'package:yo_quiz_app/src/modules/create/widgets/create_quiz_image.dart';
import 'package:yo_quiz_app/src/modules/create/widgets/quiz_action_button.dart';

class CreateQuizScreen extends StatelessWidget {
  static const String routeName = "/create-quiz-screen";
  CreateQuizScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    

    final mediaQuery = MediaQuery.of(context);

    final id = ModalRoute.of(context)!.settings.arguments as String?;


    final uIQuizCreateProvider =
        Provider.of<UIQuizCreateProvider>(context, listen: true);

    return WillPopScope(
      onWillPop: () async {
        uIQuizCreateProvider.closeCreateQuiz(context);

        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.primary,
          actions: [
            IconButton(
              onPressed: () => uIQuizCreateProvider.closeCreateQuiz(context),
              icon: Icon(Icons.close),
            ),
            const Spacer(),
            IconButton(
              onPressed: () =>
                  uIQuizCreateProvider.goToCreateQuestionsArea(context, _form),
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
                    Column(
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

                        CreateQuizForm(
                          form: _form,
                        ),

                        // TextFormField(
                        //   initialValue: createQuizProvider.title,
                        //   decoration: InputDecoration(
                        //     labelText: "Title",
                        //   ),
                        //   onChanged: (v) {
                        //     createQuizProvider.title = v;
                        //   },
                        //   validator: (v) {
                        //     if (v == null || v.isEmpty)
                        //       return "Field can not empty.";
                        //     if (v.length < 5 && v.length > 100)
                        //       return "Field can not more 100 and less 5 letters.";

                        //     return null;
                        //   },
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        // TextFormField(
                        //   initialValue: createQuizProvider.description,
                        //   onChanged: (v) {
                        //     createQuizProvider.description = v;
                        //   },
                        //   minLines: 1,
                        //   maxLines: 10,
                        //   decoration:
                        //       InputDecoration(labelText: "Description"),
                        //   validator: (v) {
                        //     if (v == null || v.isEmpty)
                        //       return "Field can not empty.";
                        //     if (v.length < 5 || v.length > 200)
                        //       return "Field can not more 200 and less 5 letters.";

                        //     return null;
                        //   },
                        // ),

                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),

                    QuizActionButton(
                      form: _form,
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
                    // Expanded(child: Container()),

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
