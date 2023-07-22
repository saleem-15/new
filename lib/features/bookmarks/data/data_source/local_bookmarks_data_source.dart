import 'package:nuntium/core/storage/local/hive_db.dart';
import 'package:nuntium/core/storage/local/model/bookmark_db_model.dart';

abstract class LocalBookmarksDataSource {
  List<BookmarkModel> getBookmarks();

  Future<void> addBookmark(BookmarkModel bookmark);

  Future<void> deleteBookmark(BookmarkModel bookmark);
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

  @override
  Future<void> deleteBookmark(BookmarkModel bookmark) async {
    return await MyHive.deleteBookmark(bookmark.url);
  }
}
