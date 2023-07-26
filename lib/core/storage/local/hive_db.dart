import 'package:hive_flutter/hive_flutter.dart';
import 'package:nuntium/core/storage/local/model/article_model.dart';

class MyHive {
  MyHive._();

  static late Box<Article> _bookmarkBox;

  static const String _bookmarkBoxName = 'bookmarks';

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

  static Future<void> saveBookmark(Article bookmark) async {
    await _bookmarkBox.put(bookmark.url, bookmark);
  }

  static Future<void> clear() async {
    await _bookmarkBox.clear();
  }

  static List<Article> getAllBookmarks() {
    return _bookmarkBox.values.toList();
  }

  static Future<void> deleteBookmark(String url) async {
    await _bookmarkBox.delete(url);
  }
}
