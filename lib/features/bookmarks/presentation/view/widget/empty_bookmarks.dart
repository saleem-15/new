import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nuntium/core/resorces/manager_assets.dart';
import 'package:nuntium/core/resorces/manager_colors.dart';
import 'package:nuntium/core/resorces/manager_fonts.dart';
import 'package:nuntium/core/resorces/manager_sizes.dart';
import 'package:nuntium/core/resorces/manager_styles.dart';

class EmptyBookmarks extends StatelessWidget {
  const EmptyBookmarks({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            height: ManagerWidth.w72,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: ManagerColors.purpleLighter,
            ),
            child: SvgPicture.asset(
              VectorIcons.book,
            ),
          ),
          SizedBox(
            height: ManagerHeight.h24,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ManagerWidth.w40,
            ),
            child: Text(
              "You haven't saved any articles yet. Start reading and bookmarking them now",
              textAlign: TextAlign.center,
              style: getMediumTextStyle(
                fontSize: ManagerFontSize.s16,
                color: ManagerColors.blackPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
