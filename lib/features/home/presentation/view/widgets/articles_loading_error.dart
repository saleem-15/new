import 'package:flutter/material.dart';
import 'package:nuntium/core/resorces/manager_assets.dart';
import 'package:nuntium/core/resorces/manager_colors.dart';
import 'package:nuntium/core/resorces/manager_fonts.dart';
import 'package:nuntium/core/resorces/manager_sizes.dart';
import 'package:nuntium/core/resorces/manager_strings.dart';
import 'package:nuntium/core/resorces/manager_styles.dart';
import 'package:nuntium/core/widgets/rect_button.dart';

Widget pageLoadingError(BuildContext _) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        ManagerAssets.error,
        width: ManagerWidth.w216,
      ),
      Text(
        ManagerStrings.errorLoadingArticles,
        style: getBoldTextStyle(
          fontSize: ManagerFontSize.s20,
          color: ManagerColors.blackDarker,
        ),
      ),
      SizedBox(
        height: ManagerHeight.h20,
      ),
      SizedBox(
        width: ManagerWidth.w120,
        height: ManagerHeight.h44,
        child: rectButton(
          onPressed: () {},
          text: 'Reftesh',
        ),
      )
    ],
  );
}
