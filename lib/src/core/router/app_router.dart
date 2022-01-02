import 'package:yo_quiz_app/src/modules/auth/screens/auth_wrapper_screen.dart';
import 'package:yo_quiz_app/src/modules/auth/screens/auth_screen.dart';
import 'package:yo_quiz_app/src/modules/create/screens/create_question_screen.dart';
import 'package:yo_quiz_app/src/modules/create/screens/create_questions_area_screen.dart';
import 'package:yo_quiz_app/src/modules/create/screens/create_quiz_screen.dart';
import 'package:yo_quiz_app/src/modules/main_navigator/screens/main_navigator_screen.dart';
import 'package:yo_quiz_app/src/modules/profile/screens/created_quizzes_screen.dart';
import 'package:yo_quiz_app/src/modules/profile/screens/profile_screen.dart';
import 'package:yo_quiz_app/src/modules/quiz/screens/quiz_main_screen.dart';

class AppRouter {
  

  static final routes = {
    AuthWrapper.routeName: (ctx) => const AuthWrapper(),
    AuthScreen.routeName: (ctx) => AuthScreen(),
    MainNavigatorScreen.routeName: (ctx) => MainNavigatorScreen(),

    ProfileScreen.routeName: (ctx) => ProfileScreen(),
    CreatedQuizzesScreen.routeName: (ctx) => CreatedQuizzesScreen(),

    CreateQuizScreen.routeName: (ctx) => CreateQuizScreen(),
    CreateQuestionsAreaScreen.routeName: (ctx) => CreateQuestionsAreaScreen(),
    CreateQuestionScreen.routeName: (ctx) => CreateQuestionScreen(),

    QuizMainScreen.routeName: (ctx) => QuizMainScreen(),
  };

  static const initialRoute = AuthWrapper.routeName;

}