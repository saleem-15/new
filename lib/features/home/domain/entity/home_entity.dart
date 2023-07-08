import 'article_entity.dart';

class HomeEntity {
  String? source;
  int totalResults;
  List<ArticleEntity>? articles;

  HomeEntity({
    required this.articles,
    required this.source,
    required this.totalResults,
  });
}
