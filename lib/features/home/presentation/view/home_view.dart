import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nuntium/core/resorces/manager_fonts.dart';
import 'package:nuntium/core/resorces/manager_icons.dart';
import 'package:nuntium/core/resorces/manager_sizes.dart';
import 'package:nuntium/core/resorces/manager_strings.dart';
import 'package:nuntium/core/resorces/manager_styles.dart';
import 'package:nuntium/core/service/icon_service.dart';
import 'package:nuntium/core/widgets/screen_header.dart';
import 'package:nuntium/core/widgets/text_field.dart';
import 'package:nuntium/features/home/presentation/controller/home_controller.dart';
import 'package:nuntium/features/home/presentation/model/article.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'widgets/article_card.dart';
import 'widgets/articles_loading_error.dart';
import 'widgets/back_to_top_button.dart';
import 'widgets/categories.dart';
import 'widgets/articles_loading_indicator.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: BackToTopButton(
        scrollController: controller.scrollController,
      ),
      body: SafeArea(
        child: SmartRefresher(
          header: WaterDropMaterialHeader(offset: ManagerHeight.h230),
          dragStartBehavior: DragStartBehavior.start,
          controller: controller.refreshController,
          onRefresh: controller.onRefresh,
          child: CustomScrollView(
            controller: controller.scrollController,
            slivers: [
              ///Header
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w20),
                  child: Header(
                    title: ManagerStrings.browse,
                    paragraph: ManagerStrings.homeParagraph,
                  ),
                ),
              ),

              ///search field
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w20),
                  child: MyTextField(
                    controller: controller.searchController,
                    textInputAction: TextInputAction.search,
                    onFieldSubmitted: controller.onSearchPressed,
                    hintText: ManagerStrings.search,
                    icon: IconService.getIcon(
                      icon: ManagerIcons.search,
                    ),
                    suffixIcon: IconService.getIcon(
                      icon: ManagerIcons.microphone,
                    ),
                  ),
                ),
              ),

              ///Categories
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: ManagerHeight.h24),
                  child: const Categories(),
                ),
              ),

              ///Articles list
              PagedSliverList<int, Article>(
                pagingController: controller.pagingController,
                builderDelegate: PagedChildBuilderDelegate<Article>(
                  animateTransitions: true,
                  itemBuilder: (_, article, __) => Center(
                    key: Key(article.url!),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: ManagerHeight.h24),
                      child: ArticleCard(
                        article: article,
                        onPressed: () => controller.onArticleCardPressed(article),
                        onBookmarkPressed: () => controller.onBookmarkPressed(article),
                      ),
                    ),
                  ),

                  /// No articles
                  noItemsFoundIndicatorBuilder: (_) => Center(
                    child: Text(
                      ManagerStrings.noArticlesFound,
                      style: getSemiBoldTextStyle(
                        fontSize: ManagerFontSize.s24,
                      ),
                    ),
                  ),

                  /// Loading Error
                  firstPageErrorIndicatorBuilder: pageLoadingError,

                  /// Loading Indicator
                  firstPageProgressIndicatorBuilder: loadingArticlesIndicator,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
