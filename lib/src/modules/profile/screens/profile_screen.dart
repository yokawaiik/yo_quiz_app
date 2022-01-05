import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/src/provider.dart';
import 'package:yo_quiz_app/src/modules/auth/provider/auth_provider.dart';
import 'package:yo_quiz_app/src/modules/profile/models/user_profile.dart';
import 'package:yo_quiz_app/src/modules/profile/provider/user_profile_provider.dart';
import 'package:yo_quiz_app/src/modules/profile/screens/created_quizzes_screen.dart';
import 'package:yo_quiz_app/src/modules/profile/widgets/profile_image.dart';

class ProfileScreen extends StatelessWidget {
  static const String routeName = "/profile";

  const ProfileScreen({Key? key}) : super(key: key);

  void _goToCreatedQuizzesScreen(
      BuildContext context, UserProfile userProfile) {
    Navigator.of(context).pushNamed(
      CreatedQuizzesScreen.routeName,
      arguments: userProfile,
    );
  }

  Future<void> _setProfileImage(BuildContext context) async {
    final imagePicker = ImagePicker();

    final pickedImage = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    if (pickedImage == null) return;

    await Provider.of<UserProfileProvider>(context, listen: false)
        .setProfileImage(File(pickedImage.path));
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final userUid = ModalRoute.of(context)!.settings.arguments as String?;

    // return FutureBuilder<UserProfile>(
    return StreamBuilder<UserProfile?>(
      // future:
      //     Provider.of<UserProfileProvider>(context).loadUserProfile(userUid),
      stream: Provider.of<UserProfileProvider>(context).userProfile(userUid),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Icon(
              Icons.error,
              color: Theme.of(context).colorScheme.error,
              size: 200,
            ),
          );
        } else if (snapshot.data == null) {
          return Center(
            child: Icon(
              Icons.no_accounts,
              color: Theme.of(context).colorScheme.secondary,
              size: 200,
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
                    case "1":
                      _goToCreatedQuizzesScreen(context, userProfile);
                      break;
                    case "0":
                      context.read<AuthProvider>().signOut();
                      break;
                  }
                },
                itemBuilder: (ctx) => [
                  const PopupMenuItem(
                    value: "1",
                    child: Text('My created quizzes'),
                    enabled: true,
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
                ProfileImage(
                  height: (mediaQuery.size.height -
                          mediaQuery.padding.top -
                          appBar.preferredSize.height) *
                      (3 / 7),
                  userProfile: userProfile,
                  action: PopupMenuButton(
                    icon: Icon(
                      Icons.edit,
                      color: Theme.of(context).colorScheme.onSecondary,
                      size: 30,
                    ),
                    itemBuilder: (_) => [
                      PopupMenuItem(
                        child: Text("Select profile image"),
                        onTap: () => _setProfileImage(context),
                      ),
                    ],
                  ),
                  // onTap: _setProfileImage(File image)
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
                        (4 / 7),
                  ),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      ListTile(
                        leading: Icon(Icons.library_books),
                        title: Text("Created quizzes"),
                        subtitle: Text("Look at created quizzes by user"),
                        enabled: true,
                        onTap: () =>
                            _goToCreatedQuizzesScreen(context, userProfile),
                      ),
                      if (userProfile.isCurrentUser)
                        ListTile(
                          leading: Icon(Icons.logout),
                          title: Text("Logout"),
                          subtitle: Text("Exit from app"),
                          onTap: () async {
                            await Provider.of<AuthProvider>(
                              context,
                              listen: false,
                            ).signOut();
                          },
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
