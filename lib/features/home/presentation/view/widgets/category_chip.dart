import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nuntium/core/resorces/manager_colors.dart';
import 'package:nuntium/core/resorces/manager_fonts.dart';
import 'package:nuntium/core/resorces/manager_sizes.dart';
import 'package:nuntium/core/resorces/manager_styles.dart';

class CategoryChip extends StatelessWidget {
  final String text;
  final bool isChecked;
  final void Function()? onPressed;

  const CategoryChip({
    super.key,
    required this.text,
    required this.isChecked,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: isChecked ? ManagerColors.purplePrimary : ManagerColors.greyLighter,
        borderRadius: BorderRadius.all(
          Radius.circular(ManagerRadius.r20),
        ),
      ),
      child: MaterialButton(
        padding: EdgeInsets.zero,
        splashColor: ManagerColors.transparent,
        onPressed: onPressed,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ManagerWidth.w6,
          ),
          child: Text(
            tr(text),
            style: getSemiBoldTextStyle(
              fontSize: ManagerFontSize.s12,
              color: isChecked ? ManagerColors.white : ManagerColors.greyPrimary,
            ),
          ),
        ),
      ),
    );
  }
}
