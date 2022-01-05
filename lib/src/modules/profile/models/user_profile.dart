import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfile {
  late final String uid;
  late final String email;
  late String fullName;
  late final String login;

  late String? avatar;

  late final bool isCurrentUser;

  UserProfile({
    required this.uid,
    required this.email,
    required this.fullName,
    required this.login,
    
    required this.isCurrentUser,
    required this.avatar,
  });

  UserProfile.fromDoc(
    DocumentSnapshot<Map<String, dynamic>> doc,
    String currentUserUid,
  ) {

    uid = doc.id;
    isCurrentUser = uid == currentUserUid ? true : false;

    final userData = doc.data()!;

    email = userData["email"];
    fullName = userData["fullName"];
    login = userData["login"];
    avatar =
        (userData["avatar"].toString().isNotEmpty ? userData["avatar"] : null);

    

  }

  // static Stream<UserProfile> fromFirebaseUser(User user, String currentUserUid) {
  //   uid = user.uid;
  //   isCurrentUser = uid == currentUserUid ? true : false;

    
  //   email = user.;
  //   fullName = userData["fullName"];
  //   login = userData["login"];
  //   avatar =
  //       (userData["avatar"].toString().isNotEmpty ? userData["avatar"] : null);
  // }
}
