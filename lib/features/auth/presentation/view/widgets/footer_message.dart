import 'package:flutter/material.dart';
import 'package:nuntium/core/resorces/manager_colors.dart';
import 'package:nuntium/core/resorces/manager_fonts.dart';
import 'package:nuntium/core/resorces/manager_styles.dart';

Widget footerMessage({
  required String message,
  required String clickableText,
  required Function() onPressed,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        message,
        style: getMediumTextStyle(
          fontSize: ManagerFontSize.s16,
          color: ManagerColors.blackLighter,
        ),
      ),
      InkWell(
        onTap: onPressed,
        child: Text(
          clickableText,
          style: getMediumTextStyle(
            fontSize: ManagerFontSize.s16,
            color: ManagerColors.blackPrimary,
          ),
        ),
      ),
    ],
  );
}
