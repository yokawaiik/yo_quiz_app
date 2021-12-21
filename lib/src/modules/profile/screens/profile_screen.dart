import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:yo_quiz_app/src/modules/auth/provider/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = "/profile";

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
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
            itemBuilder: (ctx) => [
              const PopupMenuItem(
                value: "1",
                child: Text('My quiz'),
                enabled: false,
              ),
              
              const PopupMenuItem(
                value: "0",
                child: Text('Sign Out'),
              ),
            ],
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Icon(
              Icons.person,
              size: 300,
              color: Theme.of(context).colorScheme.primary,
            ),
          )
        ],
      ),
    );
  }
}
