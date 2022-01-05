import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:yo_quiz_app/src/core/widgets/quiz_image.dart';
import 'package:yo_quiz_app/src/modules/create/screens/create_question_screen.dart';
import 'package:yo_quiz_app/src/modules/create/screens/create_quiz_screen.dart';
import 'package:yo_quiz_app/src/modules/profile/models/created_quiz.dart';
import 'package:yo_quiz_app/src/modules/profile/models/user_profile.dart';
import 'package:yo_quiz_app/src/modules/profile/provider/created_quizzes_provider.dart';
import 'package:yo_quiz_app/src/modules/quiz/screens/quiz_main_screen.dart';

class CreatedQuizzesScreen extends StatelessWidget {
  static const String routeName = "/created-quizzes";

  // var _scaffoldKey = GlobalKey<ScaffoldState>();

  CreatedQuizzesScreen({Key? key}) : super(key: key);

  UserProfile? _userProfile;

  void _openQuiz(BuildContext context, String id) {
    Navigator.of(context).pushNamed(QuizMainScreen.routeName, arguments: id);
  }

  Future<void> _shareQuiz(BuildContext context, String id) async {
    await Clipboard.setData(ClipboardData(text: id));

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Code Copied to clipboard'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    _userProfile ??= ModalRoute.of(context)!.settings.arguments as UserProfile;

    return Scaffold(
      // key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Created quizzes by user"),
      ),
      body: Container(
        child: StreamBuilder<List<CreatedQuiz>>(
          stream: Provider.of<CreatedQuizzesProvider>(context)
              .createdQuizzes(_userProfile!.uid),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Icon(
                  Icons.error,
                  color: Theme.of(context).colorScheme.error,
                  size: 200,
                ),
              );
            } else if (snapshot.hasData && snapshot.data!.isEmpty) {
              return Center(
                child: Icon(
                  Icons.quiz,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              );
            }

            final createdQuizzes = snapshot.data!;

            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              itemCount: createdQuizzes.length,
              itemBuilder: (_, i) => Card(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Column(
                    children: [
                      // Text(createdQuizzes[i].description),
                      // Text(createdQuizzes[i].id),
                      GestureDetector(
                        onTap: () => _openQuiz(context, createdQuizzes[i].id),
                        child: Stack(
                          children: [
                            QuizImage(createdQuizzes[i].quizImage),
                            Positioned(
                              bottom: 10,
                              left: 10,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                color: Theme.of(context)
                                    .colorScheme
                                    .background
                                    .withOpacity(0.6),
                                child: Text(createdQuizzes[i].title,
                                    style: TextStyle(
                                      fontSize: Theme.of(context)
                                          .textTheme
                                          .headline6!
                                          .fontSize,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground,
                                    )),
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () =>
                                _shareQuiz(context, createdQuizzes[i].id),
                            icon: Icon(Icons.share),
                          ),
                          // IconButton(
                          //   onPressed: null,
                          //   icon: Icon(Icons.edit),
                          // ),
                          IconButton(
                            onPressed: null,
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.of(context).pushNamed(CreateQuizScreen.routeName);
      },
      child: Icon(Icons.note_add_outlined),
      ),
    );
    
  }
}
