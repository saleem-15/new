import 'package:hive_flutter/hive_flutter.dart';
import 'package:nuntium/core/storage/local/model/bookmark_db_model.dart';

class MyHive {
  MyHive._();

  static late Box<BookmarkModel> _bookmarkBox;

  static const String _bookmarkBoxName = 'bookmark';

  /// pass testPath only if you are testing hive
  static Future<void> init({Function(HiveInterface)? registerAdapters, String? testPath}) async {
    if (testPath != null) {
      Hive.init(testPath);
    } else {
      await Hive.initFlutter();
    }
    await registerAdapters?.call(Hive);
    await initBookmarkBox();
  }

  static Future<void> initBookmarkBox() async {
    _bookmarkBox = await Hive.openBox(_bookmarkBoxName);
  }

  static Future<void> saveBookmark(BookmarkModel bookmark) async {
    await _bookmarkBox.put(bookmark.title, bookmark);
  }

  static List<BookmarkModel> getAllBookmarks() {
    return _bookmarkBox.values.toList();
  }

  static Future<bool> deleteBookmark(String title) async {
    try {
      await _bookmarkBox.delete(title);
      return true;
    } catch (error) {
      return false;
    }
  }
}
