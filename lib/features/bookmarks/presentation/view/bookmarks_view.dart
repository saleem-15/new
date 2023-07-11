import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
              Visibility(
                visible: controller.bookmarks.isNotEmpty,
                replacement: const SliverFillRemaining(
                  child: EmptyBookmarks(),
                ),
                child: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: controller.bookmarks.length,
                    (_, index) => Padding(
                      padding: EdgeInsets.only(bottom: ManagerHeight.h16),
                      child: BookmarkListTile(
                        bookmark: controller.bookmarks[index],
                      ),
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
