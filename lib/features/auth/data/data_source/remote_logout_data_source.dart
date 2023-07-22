import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';

abstract class RemoteLogoutDataSource {
  Future<void> logout();
}

class RemoteLogoutDataSourceImpl implements RemoteLogoutDataSource {
  final _auth = FirebaseAuth.instance;
  
  @override
  Future<void> logout() async {
    return await _auth.signOut();
  }

  Future<void> checkUserSignInMethod() async {
    final user = _auth.currentUser;

    if (user == null) {
      log("User is not signed in");
      return;
    }

    if (user.providerData.isEmpty) {
      log("User signed in with anonymous or other providers");
      return;
    }

    for (UserInfo userInfo in user.providerData) {
      if (userInfo.providerId == "password") {
        log("User signed in with email and password");
      } else if (userInfo.providerId == "google.com") {
        log("User signed in with Google");
      }
    }
  }
}
