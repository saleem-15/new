import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nuntium/core/resorces/manager_assets.dart';
import 'package:nuntium/core/resorces/manager_colors.dart';
import 'package:nuntium/core/resorces/manager_fonts.dart';
import 'package:nuntium/core/resorces/manager_sizes.dart';
import 'package:nuntium/core/resorces/manager_styles.dart';
import 'package:nuntium/core/storage/local/model/bookmark_db_model.dart';

class BookmarkListTile extends StatelessWidget {
  final BookmarkModel bookmark;
  final void Function()? onPressed;

  final ImageProvider image;

  BookmarkListTile({
    super.key,
    required this.bookmark,
    required this.onPressed,
  }) : image = (bookmark.imageUrl == null
            ? const AssetImage(ManagerAssets.news_placeholder)
            : CachedNetworkImageProvider(bookmark.imageUrl!)) as ImageProvider;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: ManagerColors.transparent,
      borderRadius: BorderRadius.circular(ManagerRadius.r2),
      onTap: onPressed,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(ManagerRadius.r12),
            child: SizedBox.square(
              dimension: ManagerWidth.w96,
              child: Image(
                image: image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: ManagerWidth.w16,
          ),
          Expanded(
            child: Text(
              bookmark.title,
              style: getSemiBoldTextStyle(
                fontSize: ManagerFontSize.s16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
