import 'package:get/get.dart';
import 'package:nuntium/config/constants.dart';
import 'package:nuntium/config/dependency_injection.dart';
import 'package:nuntium/core/cache/cache.dart';
import 'package:nuntium/core/storage/local/model/article_model.dart';
import 'package:nuntium/features/bookmarks/domain/use_case/get_bookmark_use_case.dart';
import 'package:nuntium/features/home/presentation/controller/home_controller.dart';
import 'package:nuntium/routes/routes.dart';

import '../../domain/use_case/delete_bookmark_use_case.dart';

class BookmarksController extends GetxController {
  final _viewBookmarkUseCase = getIt<ViewBookmarksUseCase>();
  final _deleteBookmarkUseCase = getIt<DeleteBookmarkUseCase>();

  List<Article> bookmarks = [];

  bool isBookmarksFetched = false;

  @override
  void onInit() {
    super.onInit();
    fetchBookmarks();
  }

  Future<void> fetchBookmarks() async {
    (await _viewBookmarkUseCase.execute()).fold(
      (l) => Get.rawSnackbar(message: l.message),
      (r) {
        bookmarks = r;
        isBookmarksFetched = true;
        update([GetBuilderIDs.bookmarks_list]);
      },
    );
  }

  updateBookmarksList() async {
    await fetchBookmarks();
    update([GetBuilderIDs.bookmarks_list]);
  }

  onBookmarkTilePressed(Article bookmark) {
    CacheData.setArticle(bookmark);
    Get.toNamed(Routes.article);
  }

  Future<void> onBookmarkDismissed(Article bookmark) async {
    (await _deleteBookmarkUseCase.execute(
      DeleteBookmarkUseCaseInput(bookmark: bookmark),
    ))
        .fold(
      (l) => Get.rawSnackbar(message: l.message),
      (r) {
        bookmarks.remove(bookmark);
        bookmark.isSaved = false;

        /// update bookmark icon in HomeView
        Get.find<HomeController>().updateBookmarkIcon(bookmark);
        update([GetBuilderIDs.bookmarks_list]);
      },
    );
  }
}
