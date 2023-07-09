import 'package:get/get.dart';
import 'package:nuntium/config/dependency_injection.dart';
import 'package:nuntium/core/storage/local/model/bookmark_db_model.dart';
import 'package:nuntium/features/bookmarks/domain/use_case/get_bookmark_use_case.dart';

class BookmarksController extends GetxController {
  late final _aviewBookmarkUseCase = instance<ViewBookmarksUseCase>();

  List<BookmarkModel> bookmarks = [];

  bool isBookmarksFetched = false;

  @override
  void onInit() {
    super.onInit();
    fetchBookmarks();
  }

  Future<void> fetchBookmarks() async {
    (await _aviewBookmarkUseCase.execute()).fold(
      (l) => Get.rawSnackbar(message: l.message),
      (r) {
        bookmarks = r;
        isBookmarksFetched = true;
        update();
      },
    );
  }
}
