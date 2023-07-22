import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:nuntium/config/constants.dart';
import 'package:nuntium/core/resorces/manager_icons.dart';
import 'package:nuntium/core/resorces/manager_sizes.dart';
import 'package:nuntium/core/resorces/manager_strings.dart';
import 'package:nuntium/core/widgets/screen_header.dart';

import '../controller/bookmarks_controller.dart';
import 'widget/bookmark_tile.dart';
import 'widget/empty_bookmarks.dart';

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
                child: Header(
                  title: ManagerStrings.bookmarks,
                  paragraph: ManagerStrings.bookmarksParagraph,
                ),
              ),
              GetBuilder<BookmarksController>(
                assignId: true,
                id: GetBuilderIDs.bookmarks_list,
                builder: (controller) => Visibility(
                  visible: controller.bookmarks.isNotEmpty,
                  replacement: const SliverFillRemaining(
                    child: EmptyBookmarks(),
                  ),
                  child: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: controller.bookmarks.length,
                      (_, index) {
                        final bookmark = controller.bookmarks[index];
                        
                        return Dismissible(
                          key: Key('$index'),
                          direction: DismissDirection.startToEnd,
                          onDismissed: (_) => controller.onBookmarkDismissed(bookmark),
                          background: Container(
                            alignment: const AlignmentDirectional(-.85, 0),
                            margin: EdgeInsets.only(bottom: ManagerHeight.h16),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(ManagerRadius.r12),
                            ),

                            /// delete icon
                            child: SvgPicture.asset(
                              ManagerIcons.delete,

                              /// icon color white (library way)
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                              width: ManagerIconSize.s28,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: ManagerHeight.h16),
                            child: BookmarkListTile(
                              bookmark: bookmark,
                              onPressed: () => controller.onBookmarkTilePressed(
                                bookmark,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
