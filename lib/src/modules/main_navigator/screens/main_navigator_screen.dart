import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:yo_quiz_app/src/modules/main_navigator/widgets/app_bottom_navigation_bar.dart';
import 'package:yo_quiz_app/src/modules/auth/provider/auth_provider.dart';
import 'package:yo_quiz_app/src/modules/profile/screens/profile_screen.dart';


class MainNavigatorScreen extends StatefulWidget {
  static const String routeName = "/main";

  const MainNavigatorScreen({Key? key}) : super(key: key);

  @override
  State<MainNavigatorScreen> createState() => _MainNavigatorScreenState();
}

class _MainNavigatorScreenState extends State<MainNavigatorScreen> {
    late Widget _currentScreen;

    late final List<Widget> _screenList;

    @override
    void initState() {
      super.initState();

      _screenList = [
        // Todo: add real screen here
        Center(child: Text("home"),),
        Center(child: Text("add"),),
        ProfileScreen()
      ];

      _currentScreen = _screenList[0];
      
    }


    void _navigate(int index) {
      setState(() {
        _currentScreen = _screenList[index];
      });
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        actions: [

          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (String i) {
              switch (i) {
                case "0":
                  context.read<AuthProvider>().signOut();
                  break;
              }
            },
            itemBuilder: (BuildContext ctx) => [
              const PopupMenuItem<String>(
                value: "0",
                child: Text('Sign Out'),
              ),
            ],
          )
        ],
      ),
      body: _currentScreen,
      bottomNavigationBar: AppBottomNavigationBar(functionNavigate: _navigate),
    );
  }
}