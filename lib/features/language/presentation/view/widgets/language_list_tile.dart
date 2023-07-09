import 'package:flutter/material.dart';
import 'package:nuntium/core/resorces/manager_colors.dart';
import 'package:nuntium/core/resorces/manager_fonts.dart';
import 'package:nuntium/core/resorces/manager_icons.dart';
import 'package:nuntium/core/resorces/manager_sizes.dart';
import 'package:nuntium/core/resorces/manager_styles.dart';
import 'package:nuntium/features/language/model/language.dart';

class LanguageListTile extends StatelessWidget {
  final Language language;
  final bool isCurrentLocale;
  final void Function()? onPressed;

  const LanguageListTile({
    super.key,
    required this.language,
    required this.isCurrentLocale,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ManagerHeight.h56,
      margin: EdgeInsets.only(bottom: ManagerHeight.h16),
      decoration: BoxDecoration(
        color: isCurrentLocale ? ManagerColors.purplePrimary : ManagerColors.greyLighter,
        borderRadius: BorderRadius.all(
          Radius.circular(
            ManagerRadius.r12,
          ),
        ),
      ),
      child: MaterialButton(
        padding: EdgeInsetsDirectional.only(
          start: ManagerWidth.w24,
          end: ManagerWidth.w16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              ManagerRadius.r12,
            ),
          ),
        ),
        splashColor: ManagerColors.greyLighter.withOpacity(.3),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              language.name,
              style: getSemiBoldTextStyle(
                fontSize: ManagerFontSize.s16,
                color: isCurrentLocale ? ManagerColors.white : ManagerColors.greyDarker,
              ),
            ),
            Visibility(
              visible: isCurrentLocale,
              child: Icon(
                ManagerIcons.check,
                color: ManagerColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
