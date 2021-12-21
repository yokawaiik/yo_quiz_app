import 'package:yo_quiz_app/src/modules/auth/screens/auth_wrapper_screen.dart';
import 'package:yo_quiz_app/src/modules/auth/screens/auth_screen.dart';
import 'package:yo_quiz_app/src/modules/main_navigator/screens/main_navigator_screen.dart';
import 'package:yo_quiz_app/src/modules/profile/screens/profile_screen.dart';

class AppRouter {
  

  static final routes = {
    AuthWrapper.routeName: (ctx) => const AuthWrapper(),
    AuthScreen.routeName: (ctx) => AuthScreen(),
    MainNavigatorScreen.routeName: (ctx) => MainNavigatorScreen(),
    ProfileScreen.routeName: (ctx) => ProfileScreen(),
  };

  static const initialRoute = AuthWrapper.routeName;

}