import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yo_quiz_app/src/core/models/preview_quiz.dart';
import 'package:yo_quiz_app/src/core/widgets/quiz_card.dart';
import 'package:yo_quiz_app/src/modules/public/provider/public_provider.dart';

class PublicScreen extends StatelessWidget {
  static const String routeName = "/public";
  const PublicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<List<PreviewQuiz>>(
          stream: Provider.of<PublicProvider>(context).quizzes,
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Icon(
                  Icons.error,
                  size: 200,
                  color: Theme.of(context).colorScheme.error,
                ),
              );
            } else if (snapshot.data == null || snapshot.data!.isEmpty) {
              return Center(
                child: Icon(
                  Icons.hourglass_empty,
                  size: 200,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              );
            }

            final quizzes = snapshot.data!;

            return ListView.separated(
              padding: EdgeInsets.all(10),
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 10,
                );
              },
              itemCount: quizzes.length,
              itemBuilder: (_, i) {
                final quiz = quizzes[i];

                print("public screen ${quiz.quizImage}");
                return QuizCard(
                  id: quiz.id,
                  image: quiz.quizImage,
                  title: quiz.title,
                  cardHeight: mediaQuery.size.height / 4,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
