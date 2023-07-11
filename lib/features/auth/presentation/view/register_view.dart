import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuntium/core/resorces/manager_icons.dart';
import 'package:nuntium/core/resorces/manager_sizes.dart';
import 'package:nuntium/core/resorces/manager_strings.dart';
import 'package:nuntium/core/validator/validator.dart';
import 'package:nuntium/core/widgets/rect_button.dart';
import 'package:nuntium/core/widgets/screen_header.dart';
import 'package:nuntium/core/widgets/text_field.dart';
import 'package:nuntium/features/auth/presentation/controller/register_controller.dart';
import 'package:nuntium/routes/routes.dart';

import 'widgets/footer_message.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                title: ManagerStrings.signUpTitle,
                paragraph: ManagerStrings.signUpParagraph,
              ),

              ///name field
              MyTextField(
                controller: controller.nameController,
                icon: ManagerIcons.user,
                hintText: ManagerStrings.username,
                keyboardType: TextInputType.text,
                validator: (value) => FieldValidator().validateFullName(value),
              ),
              SizedBox(height: ManagerHeight.h16),

              ///email field
              MyTextField(
                controller: controller.emailController,
                icon: ManagerIcons.email,
                hintText: ManagerStrings.emailAddress,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => FieldValidator().validateEmail(value),
              ),

              SizedBox(height: ManagerHeight.h16),

              ///password field
              MyTextField(
                controller: controller.passwordController,
                icon: ManagerIcons.password,
                keyboardType: TextInputType.text,
                isObscureText: true,
                hintText: ManagerStrings.password,
                validator: (value) => FieldValidator().validatePassword(value),
              ),
              SizedBox(height: ManagerHeight.h16),

              ///repeatNewPassword field
              MyTextField(
                controller: controller.confirmPasswordController,
                icon: ManagerIcons.password,
                textInputAction: TextInputAction.done,
                isObscureText: true,
                hintText: ManagerStrings.repeatNewPassword,
                validator: (value) => FieldValidator().validatePassword(value),
              ),
              SizedBox(height: ManagerHeight.h16),

              rectButton(
                onPressed: () => controller.register(),
                text: ManagerStrings.signUp,
              ),

              const Spacer(),
              footerMessage(
                onPressed: () => Get.offAllNamed(Routes.loginView),
                message: ManagerStrings.signUpFooterMessage,
                clickableText: ManagerStrings.signIn,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
