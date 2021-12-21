import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:yo_quiz_app/src/core/widgets/app_bottom_navigation_bar.dart';
import 'package:yo_quiz_app/src/modules/auth/provider/auth_provider.dart';


class MainScreen extends StatelessWidget {
  static const String routeName = "/main";

  const MainScreen({Key? key}) : super(key: key);

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
      bottomNavigationBar: AppBottomNavigationBar(),
    );
  }
}