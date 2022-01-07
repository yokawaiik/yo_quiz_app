import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yo_quiz_app/src/core/models/preview_quiz.dart';
import 'package:yo_quiz_app/src/core/widgets/quiz_card.dart';
import 'package:yo_quiz_app/src/modules/home/provider/home_provider.dart';

class HomeQuizCard extends StatelessWidget {
  PreviewQuiz quiz;
  double cardHeight;

  HomeQuizCard(this.quiz, {Key? key, required this.cardHeight})
      : super(key: key);

  Future<void> _quizRemove(BuildContext context, String id) async {
    await showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text('Delete quiz'),
          content: Text('Do you want delete quiz?'),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('No')),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Provider.of<HomeProvider>(context, listen: false)
                    .removeQuiz(id);
              },
              child: Text('Yes!'),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
        future: Provider.of<HomeProvider>(context, listen: false)
            .loadQuizImage(quiz.quizImageRef!),
        builder: (_, snapshot) {
          String? image;
          if (snapshot.connectionState != ConnectionState.waiting &&
              snapshot.data == null) {
            image = snapshot.data!;
          }

          return QuizCard(
            id: quiz.id,
            // image: quiz.quizImageRef,
            image: image,
            title: quiz.title,
            onLongPress: () => _quizRemove(context, quiz.id),
            // cardHeight: mediaQuery.size.height / 4,
            cardHeight: cardHeight,
          );
        });
  }
}
