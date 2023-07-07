import 'package:flutter/material.dart';
import 'package:nuntium/core/resorces/manager_assets.dart';
import 'package:nuntium/core/resorces/manager_sizes.dart';

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
          ],
        ),
        SizedBox(
          height: ManagerHeight.h24,
        )
      ],
    );
  }
}
