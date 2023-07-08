import 'dart:developer';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:nuntium/config/constants.dart';
import 'package:nuntium/config/dependency_injection.dart';
import 'package:nuntium/features/home/domain/mapper/home_entity_mapper.dart';

import '../../domain/use_case/home_use_case.dart';
import '../model/article.dart';

class HomeController extends GetxController {
  final PagingController<int, Article> pagingController = PagingController(firstPageKey: 0);

  final _homeUseCase = instance<HomeUseCase>();

  int page = 1;
  late int totalResults;

  List<Article> articles = [];

  @override
  void onInit() {
    super.onInit();
    pagingController.addPageRequestListener(_fetchPage);
  }

  bool changeColor({required bool isChecked}) {
    isChecked = !isChecked;
    update();
    return isChecked;
  }

  Future<List<Article>> fetchArticles(int page) async {
    log('(fetchArticles) page: $page');
    return (await _homeUseCase.execute(
      HomeUseCaseInput(
        page: page,
        pageSize: ApiConstants.homeaPgeSizeValue,
        country: 'us',
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
      final newFetchedArticles = await fetchArticles(pageKey);
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
}
