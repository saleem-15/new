import 'package:firebase_auth/firebase_auth.dart';

abstract class RemoteLogoutDataSource {
  Future<void> logout();
}

class RemoteLogoutDataSourceImpl implements RemoteLogoutDataSource {
  @override
  Future<void> logout() async {
    return await FirebaseAuth.instance.signOut();
  }
}
