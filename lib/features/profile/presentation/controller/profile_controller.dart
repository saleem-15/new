import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuntium/config/dependency_injection.dart';
import 'package:nuntium/core/storage/local/app_settings_shared_preferences.dart';
import 'package:nuntium/routes/routes.dart';

class ProfileController extends GetxController {
  final _appSettingsSharedPreferences = instance<AppSettingsSharedPreferences>();

  late String name;
  late String email;
  late bool isNotificationOn;
  late ImageProvider userImage;

  Future<void> setIsNotificationOn(bool value) async {
    isNotificationOn = value;
    await _appSettingsSharedPreferences.setNotificationOn(value);
    update();
  }

  @override
  void onInit() {
    super.onInit();
    //Todo: get user data from storage
    // I've done!
    name = _appSettingsSharedPreferences.getName();
    email = _appSettingsSharedPreferences.getEmail();
    isNotificationOn = _appSettingsSharedPreferences.getNotificationOn();

    userImage = const AssetImage('assets/images/user_image.png');
  }

  changePassword() {
    Get.toNamed(Routes.change_password);
  }

  privacy() {}

  termsAndConditions() {
    Get.toNamed(Routes.termsAndConditions);
  }

  signout() {}

  language() {
    Get.toNamed(Routes.language);
  }

  notification() {
    setIsNotificationOn(!isNotificationOn);
  }
}
