import '../../domain/mapper/article_mapper.dart';
import 'package:nuntium/core/storage/local/model/article_model.dart';
import '../../presentation/model/home.dart';
import '../entity/home_entity.dart';

extension HomeEntityMapper on HomeEntity {
  Home toPresentation() {
    return Home(
      source: source,
      totalResults: totalResults,
      articles: articles
              ?.map(
                (article) => article.toPresentation(),
              )
              .toList() ??
          <Article>[],
    );
  }
}
