import 'package:flutter/material.dart';
import 'package:nuntium/core/resorces/manager_colors.dart';
import 'package:nuntium/core/resorces/manager_fonts.dart';
import 'package:nuntium/core/resorces/manager_sizes.dart';
import 'package:nuntium/core/resorces/manager_styles.dart';
import 'package:nuntium/core/service/icon_service.dart';

import '../util/size_util.dart';

class MyTextField extends StatelessWidget {
  final bool isObscureText;
  final TextEditingController controller;
  final IconData icon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? hintText;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final void Function(String)? onChange;

  const MyTextField({
    super.key,
    required this.controller,
    required this.icon,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.hintText,
    this.validator,
    this.focusNode,
    this.onChange,
    this.isObscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextFormField(
        controller: controller,
        focusNode: focusNode,
        validator: validator,
        onChanged: onChange,
        textInputAction: textInputAction,
        keyboardType: keyboardType,
        cursorColor: ManagerColors.purplePrimary,
        style: getMediumTextStyle(
          fontSize: ManagerFontSize.s16,
          color: ManagerColors.blackPrimary,
        ),
        obscureText: isObscureText,
        decoration: InputDecoration(
          filled: true,
          fillColor: ManagerColors.greyLighter,
          focusColor: ManagerColors.white,
          hintText: hintText,

          // Adjust the padding as needed (to get the needed height)
          contentPadding: EdgeInsets.symmetric(
            vertical: ManagerHeight.h20,
          ), 

          hintStyle: getMediumTextStyle(
            fontSize: ManagerFontSize.s16,
            color: ManagerColors.greyPrimary,
          ),
          prefixIcon: IconService().getIcon(
            icon: icon,
            iconSize: ManagerFontSize.s24,
            color: ManagerColors.greyPrimary,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ManagerColors.purplePrimary,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(
                ManagerRadius.r12,
              ),
            ),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ManagerColors.white,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(
                ManagerRadius.r12,
              ),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ManagerColors.white,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(
                ManagerRadius.r12,
              ),
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: ManagerColors.white,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(
                ManagerRadius.r12,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
