import 'package:flutter/material.dart';
import 'package:yo_quiz_app/src/modules/profile/models/user_profile.dart';

class ProfileImage extends StatelessWidget {
   ProfileImage({
    Key? key,
    required this.height,
    required this.userProfile,
     this.action,
  }) : super(key: key);

  final Widget? action;

  final double height;
  final UserProfile userProfile;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: height,
      decoration: BoxDecoration(color: colorScheme.secondary),
      child: Stack(
        children: [
          userProfile.avatar != null
              ? Image.network(
                  userProfile.avatar!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              : Center(
                  child: Icon(
                    Icons.person,
                    size: 200,
                    color: colorScheme.onSecondary,
                  ),
                ),
          Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(
                  bottom: 20,
                  left: 20,
                ),
                color: Theme.of(context).colorScheme.secondaryVariant.withOpacity(0.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userProfile.fullName,
                    style: TextStyle(
                      fontSize: textTheme.headline4!.fontSize,
                      color: colorScheme.onSecondary,
                    ),
                  ),
                  Text(
                    userProfile.login,
                    style: TextStyle(
                      fontSize: textTheme.subtitle2!.fontSize,
                      color: colorScheme.onSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (action != null) Positioned(
            right: 20,
            top: 20,
            child: action!
            
            
          ),
        ],
      ),
    );
  }
}
