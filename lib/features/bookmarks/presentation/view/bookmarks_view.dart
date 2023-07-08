import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nuntium/core/resorces/manager_fonts.dart';
import 'package:nuntium/core/resorces/manager_sizes.dart';
import 'package:nuntium/core/resorces/manager_styles.dart';
import 'package:nuntium/core/storage/local/model/bookmark_db_model.dart';
import 'package:nuntium/core/widgets/screen_header.dart';

import '../controller/bookmarks_controller.dart';

class BookmarksView extends GetView<BookmarksController> {
  const BookmarksView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w20),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: header(
                  title: 'Bookmarks',
                  paragraph: 'Saved articles to the library',
                ),
              ),

              SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: controller.bookmarks.length,
                  (_, index) => Padding(
                    padding: EdgeInsets.only(bottom: ManagerHeight.h16),
                    child: BookmarrkCard(
                      bookmark: controller.bookmarks[index],
                    ),
                  ),
                ),
              ),

              // const EmptyBookmarks(),
              // GetBuilder<BookmarksController>(
              //   builder: (controller) {
              //     if (controller.isBookmarksFetched && controller.bookmarks.isNotEmpty) {
              //       return ListView.builder(
              //         itemCount: controller.bookmarks.length,
              //         itemBuilder: (_, index) => Padding(
              //           padding: EdgeInsets.only(bottom: ManagerHeight.h16),
              //           child: const BookmarrkCard(),
              //         ),
              //       );
              //     }

              //     return const EmptyBookmarks();
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookmarrkCard extends StatelessWidget {
  final BookmarkModel bookmark;

  const BookmarrkCard({
    super.key,
    required this.bookmark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(ManagerRadius.r12),
          child: SizedBox.square(
            dimension: ManagerWidth.w96,
            child: Image.network(
              bookmark.imageUrl,
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
    );
  }
}
