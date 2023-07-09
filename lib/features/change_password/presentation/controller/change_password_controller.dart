import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:nuntium/config/dependency_injection.dart';
import 'package:nuntium/core/resorces/manager_strings.dart';
import 'package:quickalert/quickalert.dart';

import '../../domain/use_case/change_password_use_case.dart';

class ChangePasswordController extends GetxController {
  final currentPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final repeatPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final _changePasswordUseCase = instance<ChangePasswordUseCase>();

  Future<void> performChangePassword(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      _changePassword(context);
    }
  }

  Future<void> _changePassword(BuildContext context) async {
    (await _changePasswordUseCase.execute(
      ChangePasswordUseCaseInput(
        currentPassword: currentPasswordController.text,
        newPassword: newPasswordController.text,
      ),
    ))
        .fold(
      (l) async => await QuickAlert.show(
        context: context,
        title: ManagerStrings.error,
        type: QuickAlertType.error,
        text: l.message,
        confirmBtnText: ManagerStrings.ok,
      ),
      (r) async {
        await QuickAlert.show(
          context: context,
          type: QuickAlertType.success,
          autoCloseDuration: const Duration(seconds: 4),
        );

        disposeChangePassword();
        Get.back();
      },
    );
  }

  Future<bool> onWillPop() async {
    disposeChangePassword();
    return true;
  }
}
