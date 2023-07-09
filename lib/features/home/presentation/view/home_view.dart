import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nuntium/core/cache/cache.dart';
import 'package:nuntium/core/resorces/manager_colors.dart';
import 'package:nuntium/core/resorces/manager_fonts.dart';
import 'package:nuntium/core/resorces/manager_icons.dart';
import 'package:nuntium/core/resorces/manager_sizes.dart';
import 'package:nuntium/core/resorces/manager_strings.dart';
import 'package:nuntium/core/resorces/manager_styles.dart';
import 'package:nuntium/core/widgets/screen_header.dart';
import 'package:nuntium/features/home/presentation/controller/home_controller.dart';
import 'package:nuntium/features/home/presentation/model/article.dart';
import 'package:nuntium/routes/routes.dart';

import 'widgets/article_card.dart';
import 'widgets/categories.dart';



class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            ///Header
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w20),
              sliver: SliverToBoxAdapter(
                child: Header(
                  title: ManagerStrings.browse,
                  paragraph: ManagerStrings.homeParagraph,
                ),
              ),
            ),

            ///search field
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: ManagerWidth.w20),
              sliver: SliverToBoxAdapter(
                child: Container(
                  height: ManagerHeight.h56,
                  decoration: BoxDecoration(
                    color: ManagerColors.greyLighter,
                    borderRadius: BorderRadius.all(
                      Radius.circular(ManagerRadius.r16),
                    ),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsetsDirectional.symmetric(
                        vertical: ManagerHeight.h16,
                      ),
                      hintText: ManagerStrings.search,
                      hintStyle: getMediumTextStyle(
                        fontSize: ManagerFontSize.s16,
                        color: ManagerColors.greyPrimary,
                      ),
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        ManagerIcons.search,
                        color: ManagerColors.greyPrimary,
                      ),
                      suffixIcon: Icon(
                        ManagerIcons.mic,
                        color: ManagerColors.greyPrimary,
                      ),
                    ),
                  ),
                ),
              ),
            ),

            SliverPadding(
              padding: EdgeInsets.only(top: ManagerHeight.h24),
            ),

            ///Categories
            const SliverToBoxAdapter(
              child: Categories(),
            ),

            SliverPadding(
              padding: EdgeInsets.only(top: ManagerHeight.h24),
            ),

            ///Articles list
            PagedSliverList<int, Article>(
              pagingController: controller.pagingController,
              builderDelegate: PagedChildBuilderDelegate<Article>(
                noItemsFoundIndicatorBuilder: (context) {
                  return Center(
                    child: Text(
                      'No articles found',
                      style: getSemiBoldTextStyle(
                        fontSize: ManagerFontSize.s24,
                      ),
                    ),
                  );
                },
                itemBuilder: (_, article, index) => MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(ManagerRadius.r20),
                    ),
                  ),
                  splashColor: ManagerColors.greyLight.withOpacity(.1),
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    CacheData().setArticle(article);
                    Get.toNamed(Routes.article);
                  },
                  child: ArticleCard(
                    imageUrl: article.imageUrl,
                    isSaved: article.isSaved,
                    text: article.title ?? article.description ?? '',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
