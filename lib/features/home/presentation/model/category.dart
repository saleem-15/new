import 'package:easy_localization/easy_localization.dart';
import 'package:nuntium/config/constants.dart';

import 'article.dart';

class Category {
  final String _name;

  int nextPageKey = ApiConstants.firstPageKey;
  List<Article> articles = [];

  Category({
    required String name,
  })  : _name = name,
        nextPageKey = ApiConstants.firstPageKey;

  void appendArticles(List<Article> articles) {
    this.articles.addAll(articles);
  }

  String get name => tr(_name);
}
