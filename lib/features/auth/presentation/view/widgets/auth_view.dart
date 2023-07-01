import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuntium/core/resorces/manager_colors.dart';
import 'package:nuntium/core/resorces/manager_fonts.dart';
import 'package:nuntium/core/resorces/manager_icons.dart';
import 'package:nuntium/core/resorces/manager_sizes.dart';
import 'package:nuntium/core/resorces/manager_styles.dart';
import 'package:nuntium/core/widgets/rect_button.dart';
import 'package:nuntium/core/widgets/text_field.dart';
import 'package:nuntium/routes/routes.dart';

Widget authView(
    {Widget? child,
    required String title,
    required String paragraph,
    bool forgotPassword = false,
    bool password = false,
    bool confirmPassword = false,
    bool name = false,
    required String buttonText,
    String passwordHint = 'Password',
    String confirmPasswordHint = 'Repeat New Password',
    required Map<String, TextEditingController> controllers}) {
  return Scaffold(
    resizeToAvoidBottomInset: false,
    body: SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: ManagerHeight.h28,
            ),
            Text(
              title,
              style: getSemiBoldTextStyle(
                  fontSize: ManagerFontSize.s24,
                  color: ManagerColors.blackPrimary),
            ),
            SizedBox(
              height: ManagerHeight.h8,
            ),
            Text(
              paragraph,
              style: getRegularTextStyle(
                  fontSize: ManagerFontSize.s16,
                  color: ManagerColors.greyPrimary),
            ),
            SizedBox(
              height: ManagerHeight.h32,
            ),
            Visibility(
              visible: name,
              child: myTextField(
                controller:
                    controllers['nameController'] ?? TextEditingController(),
                icon: ManagerIcons.user,
              ),
            ),
            SizedBox(
              height: name ? ManagerHeight.h16 : 0,
            ),
            myTextField(
              controller:
                  controllers['emailController'] ?? TextEditingController(),
              icon: ManagerIcons.email,
            ),
            SizedBox(
              height: ManagerHeight.h16,
            ),
            Visibility(
              visible: password,
              child: myTextField(
                  controller: controllers['passwordController']!,
                  icon: ManagerIcons.password,
                  hintText: passwordHint),
            ),
            SizedBox(
              height: password ? ManagerHeight.h16 : 0,
            ),
            Visibility(
              visible: confirmPassword,
              child: myTextField(
                  controller: controllers['confirmPasswordController'] ??
                      TextEditingController(),
                  icon: ManagerIcons.password,
                  hintText: confirmPasswordHint),
            ),
            SizedBox(
              height: confirmPassword ? ManagerHeight.h16 : 0,
            ),
            Visibility(
              visible: forgotPassword,
              child: Row(
                children: [
                  Spacer(),
                  Text(
                    "Forgot Password?",
                    style: getMediumTextStyle(
                        fontSize: ManagerFontSize.s16,
                        color: ManagerColors.greyPrimary),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: ManagerHeight.h24,
            ),
            rectButton(
                onPressed: () {
                  Get.offAllNamed(Routes.register);
                },
                text: buttonText),
            child ?? SizedBox()
          ],
        ),
      ),
    ),
  );
}
