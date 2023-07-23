import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuntium/config/dependency_injection.dart';
import 'package:nuntium/core/storage/local/app_settings_shared_preferences.dart';
import 'package:nuntium/features/auth/domain/use_case/register_use_case.dart';
import 'package:nuntium/routes/routes.dart';

class RegisterController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();

  final _registerUseCase = getIt<RegisterUseCase>();
  final _appSettingsSharedPreferences = getIt<AppSettingsSharedPreferences>();

  Future<void> register() async {
    (await _registerUseCase.execute(
      RegisterUseCaseInput(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
        confirmationPassword: confirmPasswordController.text,
      ),
    ))
        .fold(
      (l) => Get.rawSnackbar(message: l.message),
      (r) {
        _appSettingsSharedPreferences
          ..setLoggedIn()
          ..setEmail(emailController.text)
          ..setName(nameController.text);

        Get.offAllNamed(Routes.select_favourite_topic);
      },
    );
  }
}
