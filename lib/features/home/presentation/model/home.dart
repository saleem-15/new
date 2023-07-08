import 'article.dart';

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
