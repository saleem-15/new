import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuntium/core/resorces/manager_strings.dart';
import 'package:nuntium/core/widgets/coming_soon_dialog.dart';

import '../../../../../core/resorces/manager_colors.dart';
import '../../../../../core/resorces/manager_fonts.dart';
import '../../../../../core/resorces/manager_sizes.dart';
import '../../../../../core/resorces/manager_styles.dart';
import '../../../../../routes/routes.dart';
import 'footer_message.dart';
import 'social_media_btn.dart';

Widget loginWidget() {
  return Expanded(
    child: Column(
      children: [
        SizedBox(
          height: ManagerHeight.h40,
        ),
        Center(
          child: Text(
            ManagerStrings.or,
            style: getSemiBoldTextStyle(
              fontSize: ManagerFontSize.s16,
              color: ManagerColors.greyPrimary,
            ),
          ),
        ),
        SizedBox(
          height: ManagerHeight.h40,
        ),
        socialButton(
          onPressed: () => showComingSoonDialog(Get.context!),
          socialMedia: SocialMedia.Google,
        ),
        SizedBox(
          height: ManagerHeight.h16,
        ),
        socialButton(
          onPressed: () => showComingSoonDialog(Get.context!),
          socialMedia: SocialMedia.Facebook,
        ),
        const Spacer(),
        footerMessage(
          message: ManagerStrings.dontHaveAnAccount,
          clickableText: ManagerStrings.signUp,
          onPressed: () => Get.offAllNamed(Routes.register),
        ),
      ],
    ),
  );
}
