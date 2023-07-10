// import 'dart:developer';

// import 'package:get/get.dart';
// import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
// import 'package:nuntium/config/constants.dart';
// import 'package:nuntium/config/dependency_injection.dart';
// import 'package:nuntium/features/home/domain/mapper/home_entity_mapper.dart';
// import 'package:nuntium/features/home/presentation/model/category.dart';

// import '../../domain/use_case/home_use_case.dart';
// import '../model/article.dart';
// import '../view/widgets/categories.dart';

// class HomeController extends GetxController {
//   final PagingController<int, Article> pagingController = PagingController(firstPageKey: 0);

//   final _homeUseCase = instance<HomeUseCase>();

//   int page = 1;
//   late int totalResults;
//   List<Article> articles = [];
//   List<Category> categories = [];

//   late String selctedCategory;

//   @override
//   void onInit() {
//     super.onInit();
//     selctedCategory = CategoriesEnum.values.first.name;
//     categories = CategoriesEnum.values.map((e) => Category(name: e.name)).toList();

//     pagingController.addPageRequestListener(_fetchPage);
//   }

//   Future<List<Article>> fetchArticles(int page) async {
//     log('(fetchArticles) page: $page');
//     return (await _homeUseCase.execute(
//       HomeUseCaseInput(
//         page: page,
//         pageSize: ApiConstants.homeaPgeSizeValue,
//         country: 'us',
//       ),
//     ))
//         .fold(
//       (l) {
//         Get.rawSnackbar(message: l.message);
//         return [];
//       },
//       (r) {
//         totalResults = r.totalResults;
//         return r.toPresentation().articles;
//       },
//     );
//   }

//   Future<void> _fetchPage(int pageKey) async {
//     try {
//       final newFetchedArticles = await fetchArticles(pageKey);
//       final totalNumFetchedArticles = newFetchedArticles.length + (pagingController.itemList?.length ?? 0);

//       final isLastPage = totalResults <= totalNumFetchedArticles;
//       if (isLastPage) {
//         pagingController.appendLastPage(newFetchedArticles);
//       } else {
//         final nextPageKey = page++;
//         pagingController.appendPage(newFetchedArticles, nextPageKey);
//       }
//     } catch (error) {
//       pagingController.error = error;
//     }
//   }

//   @override
//   void onClose() {
//     pagingController.dispose();
//     super.onClose();
//   }

//   void onCategoryPressed(String category) {
//     selctedCategory = category;
//     update();
//   }
// }

import 'dart:developer';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nuntium/config/constants.dart';
import 'package:nuntium/config/dependency_injection.dart';
import 'package:nuntium/features/home/domain/mapper/home_entity_mapper.dart';
import 'package:nuntium/features/home/presentation/model/category.dart';

import '../../domain/use_case/home_use_case.dart';
import '../model/article.dart';
import '../view/widgets/categories.dart';

class HomeController extends GetxController {
  final PagingController<int, Article> pagingController = PagingController(firstPageKey: 0);

  final _homeUseCase = instance<HomeUseCase>();

  int page = 1;
  late int totalResults;
  List<Article> articles = [];
  List<Category> categories = [];

  late String selectedCategory;

  @override
  void onInit() {
    super.onInit();
    categories = CategoriesEnum.values.map((e) => Category(name: e.name)).toList();
    selectedCategory = categories.first.name;

    pagingController.addPageRequestListener(_fetchPage);
  }

  Future<List<Article>> fetchArticles(int page, String category) async {
    log('(fetchArticles) page: $page, category: $category');
    return (await _homeUseCase.execute(
      HomeUseCaseInput(
        page: page,
        pageSize: ApiConstants.homeaPgeSizeValue,
        country: 'us',
        category: category,
      ),
    ))
        .fold(
      (l) {
        Get.rawSnackbar(message: l.message);
        return [];
      },
      (r) {
        totalResults = r.totalResults;
        return r.toPresentation().articles;
      },
    );
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newFetchedArticles = await fetchArticles(pageKey, selectedCategory);
      final totalNumFetchedArticles = newFetchedArticles.length + (pagingController.itemList?.length ?? 0);

      final isLastPage = totalResults <= totalNumFetchedArticles;
      if (isLastPage) {
        pagingController.appendLastPage(newFetchedArticles);
      } else {
        final nextPageKey = page++;
        pagingController.appendPage(newFetchedArticles, nextPageKey);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }

  void onCategoryPressed(String category) {
    selectedCategory = category;
    // Reset the page and clear the existing articles when the category changes
    page = 1;
    articles.clear();
    pagingController.refresh();
    update();
  }
}
