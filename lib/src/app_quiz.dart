import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yo_quiz_app/src/core/router/app_router.dart';
import 'package:yo_quiz_app/src/modules/auth/provider/auth_provider.dart';
import 'package:yo_quiz_app/src/theme/theme.dart';

class AppQuiz extends StatelessWidget {
  const AppQuiz({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthProvider>(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: AppRouter.routes,
        initialRoute: AppRouter.initialRoute,
        theme: messengerTheme.themeLight,
      ),
    );
  }
}