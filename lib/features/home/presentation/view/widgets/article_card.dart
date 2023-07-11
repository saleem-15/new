import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nuntium/core/resorces/manager_assets.dart';
import 'package:nuntium/core/resorces/manager_colors.dart';
import 'package:nuntium/core/resorces/manager_fonts.dart';
import 'package:nuntium/core/resorces/manager_sizes.dart';
import 'package:nuntium/core/resorces/manager_styles.dart';
import 'package:nuntium/features/home/presentation/controller/home_controller.dart';

class ArticleCard extends StatelessWidget {
  final String? imageUrl;
  final String text;
  final bool isSaved;
  final void Function()? onBookmarkPressed;
  final void Function()? onPressed;

  const ArticleCard({
    super.key,
    this.imageUrl,
    required this.onBookmarkPressed,
    required this.onPressed,
    required this.isSaved,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final imageProvider = (imageUrl == null
        ? const AssetImage(ManagerAssets.news_placeholder)
        : NetworkImage(imageUrl!)) as ImageProvider;

    return Container(
      width: ManagerWidth.w336,
      alignment: Alignment.center,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(ManagerRadius.r16),
        ),
        border: Border.all(
          width: ManagerWidth.w1,
          color: ManagerColors.greyLighter,
        ),
      ),
      child: MaterialButton(
        splashColor: ManagerColors.greyLight.withOpacity(.1),
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Column(
          children: [
            ///article card image
            Image(
              image: imageProvider,
              fit: BoxFit.cover,
              width: double.infinity,
              height: ManagerHeight.h192,
            ),

            ///article card text + icon
            SizedBox(
              height: ManagerHeight.h80,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: ManagerHeight.h12,
                  horizontal: ManagerWidth.w16,
                ),
                child: Row(
                  children: [
                    /// article title
                    Expanded(
                      child: Text(
                        text,
                        maxLines: 2,
                        style: getSemiBoldTextStyle(
                          fontSize: ManagerFontSize.s16,
                          color: ManagerColors.blackPrimary,
                        ),
                      ),
                    ),

                    /// bookmark icon
                    GetBuilder<HomeController>(
                      autoRemove: false,
                      assignId: true,
                      key: Key(text),
                      id: text,
                      builder: (_) {
                        return IconButton(
                          onPressed: onBookmarkPressed,
                          isSelected: isSaved,
                          selectedIcon: SvgPicture.asset(
                            VectorIcons.bookmark_filled,
                          ),
                          icon: SvgPicture.asset(
                            VectorIcons.bookmark,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
