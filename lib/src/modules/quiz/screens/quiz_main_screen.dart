import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yo_quiz_app/src/core/models/quiz_play.dart';
import 'package:yo_quiz_app/src/core/widgets/quiz_image.dart';
import 'package:yo_quiz_app/src/modules/quiz/provider/quiz_play_provider.dart';

class QuizMainScreen extends StatelessWidget {
  static const String routeName = "/quiz-main";

  const QuizMainScreen({Key? key}) : super(key: key);

  void _closeCreateQuiz(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final quizId = ModalRoute.of(context)!.settings.arguments as String;

    Provider.of<QuizPlayProvider>(context).loadQuiz(quizId);

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.primary,
          actions: [
            IconButton(
              onPressed: () => _closeCreateQuiz(context),
              icon: Icon(Icons.close),
            ),
            Spacer(),
          ],
          // iconTheme: IconThemeData(color: Colors.white),
          elevation: 0.0,
        ),
        // body: Consumer<QuizPlayProvider>(
        //   builder: (_, snapshot, __) {
        //     print(snapshot.quizPlay);
        //     return Center(child: Text("text"));
        //   }
        //   ),


        body: StreamBuilder<QuizPlay>(
          stream: Provider.of<QuizPlayProvider>(context).quizPlay,
          builder: (BuildContext context, snapshot) {
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
            } else if (snapshot.hasData && snapshot.data == null) {
              return Center(
                child: Text("null"),
              );
            }

            final quizPlay = snapshot.data!;
            // print(snapshot.data!.id);
            return Text(quizPlay.id);
          },
        )
        // FutureBuilder(
        //   future: Provider.of<QuizPlayProvider>(context, listen: false).loadQuiz(quizId),
        //   builder: (ctx, snapshot) {

        //     return Column(
        //       // children: [
        //       //   QuizImage(quizImage, height: 300,)
        //       // ],
        //     );
        //   }
        // ),
        );
  }
}
