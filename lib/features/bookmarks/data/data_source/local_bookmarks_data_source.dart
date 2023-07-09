import 'package:nuntium/core/storage/local/hive_db.dart';
import 'package:nuntium/core/storage/local/model/bookmark_db_model.dart';

abstract class LocalBookmarksDataSource {
  Future<void> addBookmark(BookmarkModel bookmark);
  List<BookmarkModel> getBookmarks();
}

class LocalBookmarksDataSourceImpl implements LocalBookmarksDataSource {
  @override
  Future<void> addBookmark(BookmarkModel bookmark) async {
    return await MyHive.saveBookmark(bookmark);
  }

  @override
  List<BookmarkModel> getBookmarks() {
    return MyHive.getAllBookmarks();
  }
}
