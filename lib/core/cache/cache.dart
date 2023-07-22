import 'package:nuntium/features/home/presentation/model/article.dart';

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
