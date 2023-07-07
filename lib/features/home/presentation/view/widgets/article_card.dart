import 'package:flutter/material.dart';
import 'package:nuntium/core/resorces/manager_assets.dart';
import 'package:nuntium/core/resorces/manager_colors.dart';
import 'package:nuntium/core/resorces/manager_fonts.dart';
import 'package:nuntium/core/resorces/manager_sizes.dart';
import 'package:nuntium/core/resorces/manager_styles.dart';

class ArticleCard extends StatelessWidget {
  final String? imageUrl;
  final String text;

  const ArticleCard({
    super.key,
    this.imageUrl,
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
                      onPressed: () {},
                      icon: Icon(
                        Icons.bookmark_border_outlined,
                        size: ManagerFontSize.s30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Positioned.fill(
            //   child: MaterialButton(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.all(
            //         Radius.circular(ManagerRadius.r20),
            //       ),
            //     ),
            //     splashColor: ManagerColors.greyLight.withOpacity(.1),
            //     padding: EdgeInsets.zero,
            //     onPressed: () {
            //       Get.toNamed(Routes.article);
            //     },
            //   ),
            // ),
          ],
        ),
        SizedBox(
          height: ManagerHeight.h24,
        )
      ],
    );
  }
}
