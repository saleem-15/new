import 'package:flutter/material.dart';
import 'package:nuntium/core/resorces/manager_colors.dart';
import 'package:nuntium/core/resorces/manager_fonts.dart';
import 'package:nuntium/core/resorces/manager_sizes.dart';
import 'package:nuntium/core/resorces/manager_styles.dart';

class MyTextField extends StatelessWidget {
  final bool isObscureText;
  final TextEditingController controller;
  final Widget icon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? hintText;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final void Function(String)? onChange;
  final void Function(String)? onFieldSubmitted;

  const MyTextField({
    super.key,
    required this.controller,
    required this.icon,
    this.suffixIcon,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.hintText,
    this.validator,
    this.focusNode,
    this.onChange,
    this.onFieldSubmitted,
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
        onFieldSubmitted: onFieldSubmitted,
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
          contentPadding: EdgeInsetsDirectional.only(
            top: ManagerHeight.h20,
            bottom: ManagerHeight.h20,
          ),

          hintStyle: getMediumTextStyle(
            fontSize: ManagerFontSize.s16,
            color: ManagerColors.greyPrimary,
          ),
          prefixIcon: Padding(
            padding: EdgeInsetsDirectional.only(
              /// distance between prefix icon and textField border
              start: ManagerWidth.w16,

              /// distance between prefix icon and the text
              end: ManagerWidth.w24,
            ),
            child: icon,
          ),
          suffixIcon: Padding(
            padding: EdgeInsetsDirectional.only(
              /// distance between suffix icon and textField border
              end: ManagerWidth.w16,
            ),
            child: suffixIcon,
          ),
          prefixIconConstraints: BoxConstraints.loose(Size.square(ManagerWidth.w120)),
          suffixIconConstraints: BoxConstraints.loose(Size.square(ManagerWidth.w120)),
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
          isDense: true,

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
