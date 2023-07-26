import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nuntium/config/constants.dart';
import 'package:nuntium/core/resorces/manager_assets.dart';
import 'package:nuntium/core/resorces/manager_colors.dart';
import 'package:nuntium/core/resorces/manager_fonts.dart';
import 'package:nuntium/core/resorces/manager_sizes.dart';
import 'package:nuntium/core/resorces/manager_styles.dart';
import 'package:nuntium/features/home/presentation/controller/home_controller.dart';
import 'package:nuntium/core/storage/local/model/article_model.dart';

class ArticleCard extends StatelessWidget {
  final Article article;
  final void Function()? onBookmarkPressed;
  final void Function()? onPressed;

  const ArticleCard({
    super.key,
    required this.article,
    required this.onBookmarkPressed,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final imageProvider = (article.imageUrl == null
        ? const AssetImage(ManagerAssets.news_placeholder)
        : CachedNetworkImageProvider(article.imageUrl!)) as ImageProvider;

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
              errorBuilder: (_, __, ___) => Image.asset(ManagerAssets.news_placeholder),
              fit: BoxFit.cover,
              width: double.infinity,
              height: ManagerHeight.h192,
            ),

            // FadeInImage(
            //   // image: CachedNetworkImageProvider(article.imageUrl!),
            //   image: imageProvider,
            //   placeholder: const AssetImage(ManagerAssets.news_placeholder),
            //   imageErrorBuilder: (_, __, ___) => Image.asset(ManagerAssets.news_placeholder),
            //   fit: BoxFit.cover,
            //   width: double.infinity,
            //   height: ManagerHeight.h192,
            // ),

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
                        article.displayText,
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
                      key: Key(article.displayText),
                      id: GetBuilderIDs.articleBookmarkIcon(article),
                      builder: (_) {
                        return IconButton(
                          onPressed: onBookmarkPressed,
                          isSelected: article.isSaved,
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
