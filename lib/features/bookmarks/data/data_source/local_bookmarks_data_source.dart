import 'package:nuntium/core/storage/local/hive_db.dart';
import 'package:nuntium/core/storage/local/model/article_model.dart';

abstract class LocalBookmarksDataSource {
  List<Article> getBookmarks();

  Future<void> addBookmark(Article bookmark);

  Future<void> deleteBookmark(Article bookmark);
}

class LocalBookmarksDataSourceImpl implements LocalBookmarksDataSource {
  @override
  Future<void> addBookmark(Article bookmark) async {
    return await MyHive.saveBookmark(bookmark);
  }

  @override
  List<Article> getBookmarks() {
    return MyHive.getAllBookmarks();
  }

  @override
  Future<void> deleteBookmark(Article bookmark) async {
    return await MyHive.deleteBookmark(bookmark.url!);
  }
}
