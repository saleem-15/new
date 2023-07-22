import 'article_entity.dart';

class SearchEntity {
  String? source;
  int totalResults;
  List<ArticleEntity>? articles;

  SearchEntity({
    required this.articles,
    required this.source,
    required this.totalResults,
  });
}
