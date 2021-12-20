import 'package:yo_quiz_app/src/core/utils/auth_wrapper.dart';
import 'package:yo_quiz_app/src/modules/auth/screens/auth_screen.dart';

class AppRouter {
  

  static final routes = {
    AuthWrapper.routeName: (ctx) => const AuthWrapper(),
    AuthScreen.routeName: (ctx) => AuthScreen(),
  };

  static const initialRoute = AuthWrapper.routeName;

}