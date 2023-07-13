import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuntium/core/resorces/manager_colors.dart';
import 'package:nuntium/core/resorces/manager_fonts.dart';
import 'package:nuntium/core/resorces/manager_icons.dart';
import 'package:nuntium/core/resorces/manager_sizes.dart';
import 'package:nuntium/core/resorces/manager_strings.dart';
import 'package:nuntium/core/resorces/manager_styles.dart';
import 'package:nuntium/core/service/icon_service.dart';
import 'package:nuntium/core/validator/validator.dart';
import 'package:nuntium/core/widgets/rect_button.dart';
import 'package:nuntium/core/widgets/text_field.dart';
import 'package:nuntium/features/forget_password/presentation/view/widget/verification_widget.dart';
import 'package:nuntium/routes/routes.dart';

class AuthView extends StatelessWidget {
  final Widget? child;
  final String title;
  final String paragraph;
  final bool forgotPassword;
  final bool password;
  final bool confirmPassword;
  final bool name;
  final bool verification;
  final String buttonText;
  final String? passwordHint;
  final String? confirmPasswordHint;
  final Function() onButtonPressed;
  final Map<String, TextEditingController> controllers;

  const AuthView({
    super.key,
    this.child,
    required this.title,
    required this.paragraph,
    this.forgotPassword = false,
    this.password = false,
    this.confirmPassword = false,
    this.name = false,
    this.verification = false,
    required this.buttonText,
    this.passwordHint,
    this.confirmPasswordHint,
    required this.onButtonPressed,
    required this.controllers,
  });

  @override
  Widget build(BuildContext context) {
    final FieldValidator failedValidator = FieldValidator();
    final GlobalKey<FormState> formKey = GlobalKey();

    Widget buildNameTextField() {
      if (!name) return const SizedBox();

      return MyTextField(
        controller: controllers['nameController'] ?? TextEditingController(),
        icon: IconService.getIcon(
          icon: ManagerIcons.user,
        ),
        keyboardType: TextInputType.text,
        validator: (value) => failedValidator.validateFullName(value),
      );
    }

    Widget buildPasswordField() {
      if (!password) return const SizedBox();

      return MyTextField(
        controller: controllers['passwordController'] ?? TextEditingController(),
        icon: IconService.getIcon(
          icon: ManagerIcons.password,
        ),
        keyboardType: TextInputType.text,
        isObscureText: true,
        hintText: passwordHint ?? ManagerStrings.password,
        validator: (value) => failedValidator.validatePassword(value),
      );
    }

    Widget buildConfirmPasswordField() {
      if (!confirmPassword) return const SizedBox();

      return MyTextField(
        controller: controllers['confirmPasswordController'] ?? TextEditingController(),
        icon: IconService.getIcon(
          icon: ManagerIcons.password,
        ),
        isObscureText: true,
        hintText: confirmPasswordHint ?? 'Repeat New Password',
        validator: (value) => failedValidator.validatePassword(value),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: ManagerHeight.h28,
                ),
                Text(
                  title,
                  style:
                      getSemiBoldTextStyle(fontSize: ManagerFontSize.s24, color: ManagerColors.blackPrimary),
                ),
                SizedBox(
                  height: ManagerHeight.h8,
                ),
                Text(
                  paragraph,
                  style: getRegularTextStyle(fontSize: ManagerFontSize.s16, color: ManagerColors.greyPrimary),
                ),
                SizedBox(
                  height: ManagerHeight.h32,
                ),
                !verification
                    ? Column(
                        children: [
                          buildNameTextField(),
                          SizedBox(
                            height: name ? ManagerHeight.h16 : 0,
                          ),
                          MyTextField(
                            controller: controllers['emailController'] ?? TextEditingController(),
                            icon: IconService.getIcon(
                              icon: ManagerIcons.email,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) => failedValidator.validateEmail(value),
                          ),
                          SizedBox(
                            height: ManagerHeight.h16,
                          ),
                          buildPasswordField(),
                          SizedBox(
                            height: password ? ManagerHeight.h16 : 0,
                          ),
                          buildConfirmPasswordField(),
                          SizedBox(
                            height: confirmPassword ? ManagerHeight.h16 : 0,
                          ),
                          Visibility(
                            visible: forgotPassword,
                            child: Row(
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
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          verificationNode(),
                          SizedBox(
                            height: ManagerHeight.h16,
                          )
                        ],
                      ),
                SizedBox(
                  height: forgotPassword ? ManagerHeight.h24 : 0,
                ),
                rectButton(onPressed: onButtonPressed, text: buttonText),
                child ?? const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
