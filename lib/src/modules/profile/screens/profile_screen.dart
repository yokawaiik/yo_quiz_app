import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:yo_quiz_app/src/modules/auth/provider/auth_provider.dart';
import 'package:yo_quiz_app/src/modules/profile/models/user_profile.dart';
import 'package:yo_quiz_app/src/modules/profile/provider/user_profile_provider.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = "/profile";

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final userUid = ModalRoute.of(context)!.settings.arguments as String?;

    return FutureBuilder<UserProfile>(
        future:
            Provider.of<UserProfileProvider>(context).loadUserProfile(userUid),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Icon(
                Icons.error,
                color: Theme.of(context).colorScheme.error,
              ),
            );
          }

          final userProfile = snapshot.data!;

          var appBar = AppBar(
            title: Text(userProfile.isCurrentUser
                ? "Your profile"
                : "Profile: ${userProfile.login}"),
            actions: [
              if (userProfile.isCurrentUser)
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
          );

          return Scaffold(
            appBar: appBar,
            body: SingleChildScrollView(
                child: Column(
              children: [
                Container(
                  height: (mediaQuery.size.height -
                          mediaQuery.padding.top -
                          appBar.preferredSize.height) *
                      (4 / 7),
                  decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondary),
                  child: Stack(
                    children: [
                      userProfile.avatar != null
                          ? Image.network(
                              userProfile.avatar!,
                              width: double.infinity,
                            )
                          : Center(
                              child: Icon(
                                Icons.person,
                                size: 200,
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                            ),
                      Positioned(
                        left: 20,
                        bottom: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userProfile.fullName,
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .fontSize,
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                            ),
                            Text(
                              userProfile.login,
                              style: TextStyle(
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .fontSize,
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: 0,
                    maxHeight: (mediaQuery.size.height -
                            mediaQuery.padding.top -
                            appBar.preferredSize.height) *
                        (3 / 7),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        leading: Icon(Icons.library_books),
                        title: Text("Created quizzes"),
                        subtitle: Text("Look at quizzes"),
                        enabled: false,
                      ),
                      if (userProfile.isCurrentUser)
                        ListTile(
                          leading: Icon(Icons.logout),
                          title: Text("Logout"),
                          subtitle: Text("Exit from app"),
                          onTap: () async {
                            Navigator.pop(context);
                            await Provider.of<AuthProvider>(context,
                                    listen: false)
                                .signOut();
                          },
                        ),
                    ],
                  ),
                )
              ],
            )),
          );
        });
  }
}
