import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuntium/core/resorces/manager_strings.dart';
import 'package:nuntium/features/auth/presentation/view/widgets/auth_view.dart';
import 'package:nuntium/features/auth/presentation/view/widgets/footer_message.dart';
import 'package:nuntium/features/forget_password/presentation/controller/verification_controller.dart';

class VerificationView extends StatelessWidget {
  const VerificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VerificationController>(
      init: VerificationController(),
      builder: (controller) {
        return AuthView(
          title: ManagerStrings.verificationCodeTitle,
          paragraph: ManagerStrings.verificationCodeParagraph,
          buttonText: ManagerStrings.confirm,
          onButtonPressed: () {
            controller.verifyCode();
          },
          verification: true,
          controllers: const {},
          child: footerMessage(
              onPressed: () {}, message: ManagerStrings.dontReceive, clickableText: ManagerStrings.sendAgain),
        );
      },
    );
  }
}
