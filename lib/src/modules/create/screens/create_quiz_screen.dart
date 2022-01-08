import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yo_quiz_app/src/modules/create/provider/ui_quiz_create_provider.dart';
import 'package:yo_quiz_app/src/modules/create/widgets/create_quiz_form.dart';
import 'package:yo_quiz_app/src/modules/create/widgets/create_quiz_image.dart';
import 'package:yo_quiz_app/src/modules/create/widgets/quiz_action_button.dart';

class CreateQuizScreen extends StatefulWidget {
  static const String routeName = "/create-quiz-screen";
  CreateQuizScreen({Key? key}) : super(key: key);

  @override
  State<CreateQuizScreen> createState() => _CreateQuizScreenState();
}

class _CreateQuizScreenState extends State<CreateQuizScreen> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  Widget? _quizFields;

  Widget _buildQuizFields(UIQuizCreateProvider uiQuizCreateProvider,
      MediaQueryData mediaQuery, String? id) {
    if (_quizFields == null) {
      _quizFields = FutureBuilder(
          future: id == null
              ? null
              : uiQuizCreateProvider.loadQuizToEdit(context, id),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
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
                CreateQuizForm(
                  form: _form,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            );
          });
    }
    return _quizFields!;
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    final uIQuizCreateProvider =
        Provider.of<UIQuizCreateProvider>(context, listen: false);

    final id = ModalRoute.of(context)!.settings.arguments as String?;

    print("CreateQuizScreen - reload");

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
                    _buildQuizFields(uIQuizCreateProvider, mediaQuery, id),
                    QuizActionButton(
                      form: _form,
                    ),
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
