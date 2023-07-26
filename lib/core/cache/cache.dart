import 'package:nuntium/core/storage/local/model/article_model.dart';

class CacheData {
  CacheData._();
  static Article? currentArticle;

  static void setArticle(Article value) {
    CacheData.currentArticle = value;
  }

  static Article? getArticle() {
    return currentArticle;
  }
}
