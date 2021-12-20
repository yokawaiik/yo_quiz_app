import 'package:yo_quiz_app/src/modules/auth/screens/auth_wrapper_screen.dart';
import 'package:yo_quiz_app/src/modules/auth/screens/auth_screen.dart';
import 'package:yo_quiz_app/src/modules/main/screens/main_screen.dart';

class AppRouter {
  

  static final routes = {
    AuthWrapper.routeName: (ctx) => const AuthWrapper(),
    AuthScreen.routeName: (ctx) => AuthScreen(),
    MainScreen.routeName: (ctx) => MainScreen(),
  };

  static const initialRoute = AuthWrapper.routeName;

}