import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nuntium/config/dependency_injection.dart';
import 'package:nuntium/core/storage/local/app_settings_shared_preferences.dart';
import 'package:nuntium/features/auth/domain/use_case/login_use_case.dart';
import 'package:nuntium/routes/routes.dart';

import '../../domain/use_case/login_with_google_use_case.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _loginUseCase = instance<LoginUseCase>();
  final _loginWithGoogleUseCase = instance<LoginWithGoogleUseCase>();
  final _appSettingsSharedPreferences = instance<AppSettingsSharedPreferences>();
  var formKey = GlobalKey<FormState>();

  Future<void> login() async {
    (await _loginUseCase.execute(
      LoginUseCaseInput(
        email: emailController.text,
        password: passwordController.text,
      ),
    ))
        .fold(
      (l) => {
        Get.rawSnackbar(message: l.message),
        update(),
      },
      (r) {
        _appSettingsSharedPreferences
          ..setLoggedIn()
          ..setEmail(r.email)
          ..setName(r.name);

        goToNextScreen();
      },
    );
  }

  void goToNextScreen() {
    if (_appSettingsSharedPreferences.getFavouriteViewed()) {
      Get.offAllNamed(Routes.mainView);
    } else {
      Get.offAllNamed(Routes.select_favourite_topic);
    }
  }

  Future<void> signInWithGoogle() async {
    (await _loginWithGoogleUseCase.execute()).fold(
      (l) => {
        Get.rawSnackbar(message: l.message),
        update(),
      },
      (r) {
        _appSettingsSharedPreferences
          ..setLoggedIn()
          ..setEmail(r.email)
          ..setName(r.name);

        goToNextScreen();
      },
    );
    return;
  }
}
