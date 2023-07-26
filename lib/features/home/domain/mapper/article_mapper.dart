import '../../domain/entity/article_entity.dart';
import 'package:nuntium/core/storage/local/model/article_model.dart';

extension ArticleEntityMapper on ArticleEntity {
  Article toPresentation() {
    return Article.fromData(
      //TODO: fetch isSaved property for the artice
      isSaved: false,
      author: author,
      content: content,
      description: description,
      imageUrl: imageUrl,
      publishedAt: publishedAt,
      title: title,
      url: url,
    );
  }
}
