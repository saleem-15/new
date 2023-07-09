import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nuntium/core/resorces/manager_assets.dart';
import 'package:nuntium/core/resorces/manager_colors.dart';
import 'package:nuntium/core/resorces/manager_fonts.dart';
import 'package:nuntium/core/resorces/manager_sizes.dart';
import 'package:nuntium/core/resorces/manager_styles.dart';
import 'package:nuntium/core/storage/local/hive_db.dart';
import 'package:nuntium/core/storage/local/model/bookmark_db_model.dart';

class ArticleCard extends StatelessWidget {
  final String? imageUrl;
  final String text;
  final bool isSaved;

  const ArticleCard({
    super.key,
    this.imageUrl,
    required this.isSaved,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(
                    ManagerRadius.r20,
                  ),
                ),
              ),
              child: Image(
                image: (imageUrl == null
                    ? const AssetImage(ManagerAssets.news_placeholder)
                    : NetworkImage(imageUrl!)) as ImageProvider,
                fit: BoxFit.cover,
                width: ManagerWidth.w336,
                height: ManagerHeight.h272,
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: ManagerHeight.h80,
                width: ManagerWidth.w336,
                decoration: BoxDecoration(
                  color: ManagerColors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(
                      ManagerRadius.r20,
                    ),
                    bottomRight: Radius.circular(
                      ManagerRadius.r20,
                    ),
                  ),
                  border: Border.all(
                    width: ManagerWidth.w1,
                    color: ManagerColors.greyLighter,
                  ),
                ),
                child: Center(
                  child: ListTile(
                    title: Text(
                      text,
                      style: getSemiBoldTextStyle(
                          fontSize: ManagerFontSize.s16, color: ManagerColors.blackPrimary),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        MyHive.saveBookmark(
                          BookmarkModel.fromData(
                            title: text,
                            imageUrl: imageUrl!,
                          ),
                        );
                      },
                      icon: SvgPicture.asset(
                        isSaved ? VectorIcons.home : VectorIcons.bookmark_filled,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: ManagerHeight.h24,
        )
      ],
    );
  }
}
