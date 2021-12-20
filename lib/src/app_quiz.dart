import 'package:flutter/material.dart';
import 'package:yo_quiz_app/src/core/router/app_router.dart';
import 'package:yo_quiz_app/src/theme/theme.dart';

class AppQuiz extends StatelessWidget {
  const AppQuiz({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: AppRouter.routes,
      initialRoute: AppRouter.initialRoute,
      theme: messengerTheme.themeLight,
    );
  }
}