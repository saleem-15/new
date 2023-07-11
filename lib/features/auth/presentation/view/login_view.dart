import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuntium/config/localization/locale_settings.dart';
import 'package:nuntium/core/resorces/manager_colors.dart';
import 'package:nuntium/core/resorces/manager_fonts.dart';
import 'package:nuntium/core/resorces/manager_icons.dart';
import 'package:nuntium/core/resorces/manager_sizes.dart';
import 'package:nuntium/core/resorces/manager_strings.dart';
import 'package:nuntium/core/resorces/manager_styles.dart';
import 'package:nuntium/core/validator/validator.dart';
import 'package:nuntium/core/widgets/rect_button.dart';
import 'package:nuntium/core/widgets/screen_header.dart';
import 'package:nuntium/core/widgets/text_field.dart';
import 'package:nuntium/features/auth/presentation/controller/login_controller.dart';
import 'package:nuntium/routes/routes.dart';

import 'widgets/login_widget.dart';

class LoginView extends GetView<LoginController> {
  LoginView({super.key});

  final FieldValidator failedValidator = FieldValidator();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: localeSettings.textDirection,
      child: Form(
        key: controller.formKey,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(
                right: ManagerWidth.w20,
                left: ManagerWidth.w20,
                bottom: ManagerHeight.h28,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Header(
                    title: ManagerStrings.welcomeTitle,
                    paragraph: ManagerStrings.loginParagraph,
                  ),

                  ///email field
                  MyTextField(
                    controller: controller.emailController,
                    icon: ManagerIcons.email,
                    hintText: ManagerStrings.emailAddress,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => failedValidator.validateEmail(value),
                  ),
                  SizedBox(
                    height: ManagerHeight.h16,
                  ),

                  ///password field
                  MyTextField(
                    controller: controller.passwordController,
                    icon: ManagerIcons.password,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    hintText: ManagerStrings.password,
                    validator: (value) => failedValidator.validatePassword(value),
                    isObscureText: true,
                  ),
                  SizedBox(
                    height: ManagerHeight.h16,
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      InkWell(
                        onTap: () => Get.offAllNamed(Routes.forget_password),
                        child: Text(
                          ManagerStrings.forgetPassword,
                          style: getMediumTextStyle(
                              fontSize: ManagerFontSize.s16, color: ManagerColors.greyPrimary),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ManagerHeight.h24,
                  ),
                  rectButton(
                    onPressed: () => controller.login(),
                    text: ManagerStrings.signIn,
                  ),
                  loginWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
