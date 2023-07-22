
import '../../data/mapper/article_mapper.dart';
import '../../domain/entity/search_entity.dart';
import '../response/search_response.dart';

extension SearchResopnseMapper on SearchResopnse {
  SearchEntity toDomain() {
    return SearchEntity(
      source: source?.name,
      totalResults: totalResults,
      articles: articles
          ?.map(
            (article) => article.toDomain(),
          )
          .toList(),
    );
  }
}
