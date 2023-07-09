import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuntium/core/resorces/manager_colors.dart';
import 'package:nuntium/core/resorces/manager_fonts.dart';
import 'package:nuntium/core/resorces/manager_icons.dart';
import 'package:nuntium/core/resorces/manager_sizes.dart';
import 'package:nuntium/core/resorces/manager_strings.dart';
import 'package:nuntium/core/resorces/manager_styles.dart';
import 'package:nuntium/core/validator/validator.dart';
import 'package:nuntium/core/widgets/rect_button.dart';
import 'package:nuntium/core/widgets/text_field.dart';
import 'package:nuntium/features/change_password/presentation/controller/change_password_controller.dart';

class ChangePasswordView extends GetView<ChangePasswordController> {
  final FieldValidator _validator = FieldValidator();

  ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: ManagerColors.greyPrimary,
          ),
          title: Text(
            ManagerStrings.changePassword,
            style: getSemiBoldTextStyle(
              fontSize: ManagerFontSize.s24,
              color: ManagerColors.blackPrimary,
            ),
          ),
        ),
        body: GetBuilder<ChangePasswordController>(
          builder: (controller) => SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w20),
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: ManagerHeight.h16,
                    ),
                    MyTextField(
                      controller: controller.currentPasswordController,
                      icon: ManagerIcons.password,
                      hintText: ManagerStrings.currentPassword,
                      validator: (value) => _validator.validatePassword(value),
                      keyboardType: TextInputType.visiblePassword,
                      isObscureText: true,
                    ),
                    SizedBox(
                      height: ManagerHeight.h16,
                    ),
                    MyTextField(
                      controller: controller.newPasswordController,
                      icon: ManagerIcons.password,
                      hintText: ManagerStrings.newPasswordHint,
                      validator: (value) => _validator.validatePassword(value),
                      keyboardType: TextInputType.text,
                      isObscureText: true,
                    ),
                    SizedBox(
                      height: ManagerHeight.h16,
                    ),
                    MyTextField(
                      controller: controller.repeatPasswordController,
                      icon: ManagerIcons.password,
                      hintText: ManagerStrings.repeatNewPassword,
                      textInputAction: TextInputAction.done,
                      validator: (value) => _validator.validatePasswordsMatch(
                        controller.newPasswordController.text,
                        value,
                      ),
                      keyboardType: TextInputType.text,
                      isObscureText: true,
                    ),
                    SizedBox(
                      height: ManagerHeight.h16,
                    ),
                    rectButton(
                      onPressed: () => controller.performChangePassword(context),
                      text: ManagerStrings.changePassword,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
