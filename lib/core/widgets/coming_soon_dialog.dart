// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:nuntium/core/resorces/manager_assets.dart';
import 'package:nuntium/core/resorces/manager_colors.dart';
import 'package:nuntium/core/resorces/manager_sizes.dart';
import 'package:nuntium/core/resorces/manager_strings.dart';
import 'package:nuntium/core/widgets/rect_button.dart';
import 'package:quickalert/quickalert.dart';

Future<void> showComingSoonDialog(BuildContext context) async {
  Get.dialog(
    Center(
      child: Container(
        height: 270,
        margin: EdgeInsets.symmetric(horizontal: ManagerWidth.w36),
        decoration: BoxDecoration(
          color: ManagerColors.white,
          borderRadius: BorderRadius.circular(ManagerRadius.r20),
        ),
        child: Column(
          children: [
            Lottie.asset(ManagerAssets.coming_soon),
            SizedBox(
              height: ManagerHeight.h20,
            ),
            SizedBox(
              height: ManagerHeight.h64,
              child: rectButton(
                onPressed: Get.back,
                margin: const EdgeInsets.only(
                  top: 20,
                  left: 70,
                  right: 70,
                ),
                text: ManagerStrings.ok,
              ),
            )
          ],
        ),
      ),
    ),
    barrierDismissible: true,
  );
  // return QuickAlert.show(
  //   context: context,
  //   type: QuickAlertType.info,
  //   title: 'Coming Soon!',
  //   customAsset: ManagerAssets.coming_soon,
  // );
}
