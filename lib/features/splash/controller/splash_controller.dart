import 'dart:developer';

import 'package:get/get.dart';
import 'package:nuntium/config/constants.dart';
import 'package:nuntium/config/dependency_injection.dart';
import 'package:nuntium/core/storage/local/app_settings_shared_preferences.dart';
import 'package:nuntium/main.dart';
import 'package:nuntium/routes/routes.dart';

class SplashController extends GetxController {
  final AppSettingsSharedPreferences _appSettingsSharedPreferences = getIt<AppSettingsSharedPreferences>();

  @override
  void onInit() {
    super.onInit();
    Future.delayed(
      const Duration(seconds: Constants.splashDuration),
      _navigateToNextScreen,
    );
  }

  void _navigateToNextScreen() {
    if (!_appSettingsSharedPreferences.getOutBoardingViewed()) {
      Get.offAllNamed(Routes.outBoardingView);
      return;
    }

    if (!_appSettingsSharedPreferences.loggedIn()) {
      Get.offAllNamed(Routes.loginView);
      return;
    }

    Get.offAllNamed(Routes.mainView);
  }

  @override
  void onClose() {
    log('onClose');

    statusAndNavigationBarSettings();
    super.onClose();
  }
}
