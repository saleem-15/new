import 'package:firebase_auth/firebase_auth.dart';
import 'package:nuntium/core/storage/local/app_settings_shared_preferences.dart';
import '../request/change_password_request.dart';

abstract class RemoteChangePasswordDataSource {
  Future<void> changePassword(ChangePasswordRequest request);
}

class RemoteChangePasswordDataSourceImpl implements RemoteChangePasswordDataSource {
  final auth = FirebaseAuth.instance;

  final AppSettingsSharedPreferences _sharedPreferences;

  RemoteChangePasswordDataSourceImpl(this._sharedPreferences);

  @override
  Future<void> changePassword(ChangePasswordRequest request) async {
    final user = auth.currentUser;

    await auth.signInWithEmailAndPassword(
      email: _sharedPreferences.getEmail(),
      password: request.currentPassword,
    );
    return await user!.updatePassword(request.newPassword);
  }
}
