import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuntium/core/resorces/manager_strings.dart';
import 'package:nuntium/core/validator/validator.dart';
import 'package:nuntium/core/widgets/screen_header.dart';
import 'package:nuntium/features/auth/presentation/view/widgets/footer_message.dart';
import 'package:nuntium/features/forget_password/presentation/controller/forget_password_controller.dart';
import 'package:nuntium/core/resorces/manager_icons.dart';
import 'package:nuntium/core/resorces/manager_sizes.dart';
import 'package:nuntium/core/widgets/rect_button.dart';
import 'package:nuntium/core/widgets/text_field.dart';

class ForgetPasswordView extends GetView<ForgetPasswordController> {
  const ForgetPasswordView({super.key});

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
                title: ManagerStrings.forget,
                paragraph: ManagerStrings.forgetParagraph,
              ),
              MyTextField(
                controller: controller.emailController,
                icon: ManagerIcons.email,
                textInputAction: TextInputAction.done,
                hintText: ManagerStrings.emailAddress,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => FieldValidator().validateEmail(value),
              ),
              SizedBox(
                height: ManagerHeight.h16,
              ),
              rectButton(
                onPressed: controller.forgetPassword,
                text: ManagerStrings.next,
              ),
              const Spacer(),
              footerMessage(
                message: ManagerStrings.didntRecieveEmail,
                clickableText: ManagerStrings.sendAgain,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
