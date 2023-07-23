import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nuntium/config/categories._enum.dart';
import 'package:nuntium/config/constants.dart';
import 'package:nuntium/config/dependency_injection.dart';
import 'package:nuntium/core/cache/cache.dart';
import 'package:nuntium/core/storage/local/hive_db.dart';
import 'package:nuntium/core/storage/local/model/bookmark_db_model.dart';
import 'package:nuntium/features/bookmarks/presentation/controller/bookmarks_controller.dart';
import '../../domain/mapper/home_entity_mapper.dart';
import '../../presentation/model/category.dart';
import 'package:nuntium/routes/routes.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../domain/use_case/home_use_case.dart';
import '../model/article.dart';
import '../view/home_view.dart';

class HomeController extends GetxController {
  final _homeUseCase = getIt<HomeUseCase>();
  final refreshController = RefreshController();
  final scrollController = ScrollController();
  final searchController = TextEditingController();

  late final PagingController<int, Article> pagingController;
  late int totalResults;
  late List<Category> categories;
  late Category selectedCategory;

  @override
  void onInit() {
    super.onInit();

    categories = CategoriesEnum.values.map((e) => Category(name: e.name)).toList();
    selectedCategory = categories.first;

    pagingController = PagingController<int, Article>(firstPageKey: ApiConstants.firstPageKey);
    pagingController.addPageRequestListener(_fetchPage);
  }

  Future<List<Article>> _executeHomeUseCase(int page, String category) async {
    log('(_executeHomeUseCase) page: $page, selectedCategoryPage: ${selectedCategory.nextPageKey} category: $category');

    final articles = (await _homeUseCase.execute(
      HomeUseCaseInput(
        page: page,
        pageSize: ApiConstants.homeaPgeSizeValue,
        country: 'us',
        category: category,
        search: searchController.text.trim(),
      ),
    ))
        .fold(
      (l) {
        Get.rawSnackbar(message: l.message);

        throw l.message; // Throw an exception to indicate an error
      },
      (r) {
        totalResults = r.totalResults;
        log('totalResults: $totalResults');
        return r.toPresentation().articles;
      },
    );

    return articles;
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newFetchedArticles = await _executeHomeUseCase(pageKey, selectedCategory.name);
      final totalNumFetchedArticles = newFetchedArticles.length + (pagingController.itemList?.length ?? 0);

      final isLastPage = totalResults <= totalNumFetchedArticles;
      // debugger();
      if (isLastPage) {
        pagingController.appendLastPage(newFetchedArticles);
      } else {
        final nextPageKey = pageKey + 1;
        selectedCategory.nextPageKey = nextPageKey;
        pagingController.appendPage(newFetchedArticles, nextPageKey);
      }

      log('(Before) Articles Num: ${selectedCategory.articles.length}');

      /// add the new fetched articles to [selectedCategory] articles list
      selectedCategory.appendArticles(newFetchedArticles);

      log('(After) Articles Num: ${selectedCategory.articles.length}');
      // debugger();
    } catch (error) {
      pagingController.error = error;
    }
  }

  void onCategoryPressed(Category category) {
    // If the current category is pressed, do nothing
    if (category == selectedCategory) return;

    selectedCategory = category;

    /// Resets  pagingController
    pagingController.refresh();

    pagingController.nextPageKey = selectedCategory.nextPageKey;
    // debugger();

    /// Keep this if condition in order for the [loadingArticlesIndicator]
    /// to be used by the [infinite_scroll_pagination] library
    /// (thats due to the library working in a stupid way)
    if (selectedCategory.articles.isNotEmpty) {
      pagingController.itemList = selectedCategory.articles;
    }

    update([GetBuilderIDs.categories_list]);
  }

  onBookmarkPressed(Article article) async {
    if (article.isSaved) {
      await MyHive.deleteBookmark(article.url!);
    } else {
      await MyHive.saveBookmark(
        BookmarkModel.fromData(
          title: article.displayText,
          url: article.url!,
          imageUrl: article.imageUrl,
        ),
      );
    }

    article.isSaved = !article.isSaved;
    update([GetBuilderIDs.articleBookmarkIcon(article: article)]);

    Get.find<BookmarksController>().updateBookmarksList();
  }

  void onArticleCardPressed(Article article) {
    CacheData.setArticle(article);
    Get.toNamed(Routes.article);
  }

  /// Called by [SmartRefresher] in the [HomeView]
  ///
  /// When the users pulls the list down
  void onRefresh() {
    refreshArticles();

    refreshController.refreshCompleted();
  }

  /// Deletes the [selectedCategory] articles & Resets [pagingController]
  void refreshArticles() {
    selectedCategory.articles.clear();
    pagingController.refresh();
    update();
  }

  updateBookmarkIcon(BookmarkModel bookmark) {
    ///TODO: article model is not updated
    update([GetBuilderIDs.articleBookmarkIcon(bookmark: bookmark)]);
    debugger();
  }

  @override
  void onClose() {
    pagingController.dispose();
    scrollController.dispose();
    refreshController.dispose();
    searchController.dispose();

    super.onClose();
  }

  void onSearchPressed(String p1) {
    // TODO: implement search functionality for home view page controller and ui design changes accordingly to show results
  }
}
