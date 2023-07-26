import 'package:nuntium/core/storage/local/model/article_model.dart';

class Home {
  String? source;
  int? totalResults;
  List<Article> articles;

  Home({
    required this.articles,
    required this.totalResults,
    required this.source,
  });
}
