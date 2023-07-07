import 'package:nuntium/features/home/presentation/model/article.dart';

class CacheData {
  static Article? currentArticle;

  void setArticle(Article value) {
    CacheData.currentArticle = value;
  }

  Article? getArticle() {
    return currentArticle;
  }
}
