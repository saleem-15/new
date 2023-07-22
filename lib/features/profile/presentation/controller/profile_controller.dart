import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuntium/config/dependency_injection.dart';
import 'package:nuntium/core/resorces/manager_strings.dart';
import 'package:nuntium/core/storage/local/app_settings_shared_preferences.dart';
import 'package:nuntium/features/auth/domain/use_case/logout_use_case.dart';
import 'package:nuntium/routes/routes.dart';
import 'package:quickalert/quickalert.dart';

class ProfileController extends GetxController {
  final _appSettingsSharedPreferences = instance<AppSettingsSharedPreferences>();
  final _logoutUseCase = instance<LogoutUseCase>();

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

  signout(BuildContext context) async {
    await QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      title: ManagerStrings.logoutConfirmation,
      cancelBtnText: ManagerStrings.logoutConfirmationNo,
      confirmBtnText: ManagerStrings.logoutConfirmationYes,
      onConfirmBtnTap: () => _performSignout(context),
    );
  }

  _performSignout(BuildContext context) async {
    (await _logoutUseCase.execute()).fold(
      (l) => QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Oops...',
        text: l.message,
      ),
      (r) async {
        await QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          title: ManagerStrings.logoutSuccessful,
          text: ManagerStrings.seeYouAgain,
          autoCloseDuration: const Duration(seconds: 4),
        );

        ///for better user experience
        await Future.delayed(const Duration(milliseconds: 700));

        await _appSettingsSharedPreferences.clear();
        Get.offAllNamed(Routes.loginView);
      },
    );
  }

  language() {
    Get.toNamed(Routes.language);
  }

  notification() {
    setIsNotificationOn(!isNotificationOn);
  }
}
