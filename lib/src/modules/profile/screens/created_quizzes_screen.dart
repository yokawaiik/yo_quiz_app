import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yo_quiz_app/src/modules/profile/models/created_quiz.dart';
import 'package:yo_quiz_app/src/modules/profile/models/user_profile.dart';
import 'package:yo_quiz_app/src/modules/profile/provider/created_quizzes_provider.dart';

class CreatedQuizzesScreen extends StatelessWidget {
  static const String routeName = "/created-quizzes";

  CreatedQuizzesScreen({Key? key}) : super(key: key);

  UserProfile? _userProfile;

  @override
  Widget build(BuildContext context) {
    _userProfile ??= ModalRoute.of(context)!.settings.arguments as UserProfile;

    return Scaffold(
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

              return Container(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 14),
                  itemCount: createdQuizzes.length,
                  itemBuilder: (_, i) => Card(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Column(
                        children: [
                          // Text(createdQuizzes[i].description),
                          // Text(createdQuizzes[i].id),
                          createdQuizzes[i].quizImage != null
                              ? Image.network(
                                  createdQuizzes[i].quizImage!,
                                  height: 200,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  height: 200,
                                  color:
                                      Theme.of(context).colorScheme.secondary,
                                  child: Center(
                                    child: Icon(
                                      Icons.quiz,
                                      size: 100,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    ),
                                  ),
                                ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: null,
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
                ),
              );
            }),
      ),
    );
    ;
  }
}
