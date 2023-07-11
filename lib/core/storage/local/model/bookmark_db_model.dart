import 'package:hive/hive.dart';
import 'package:nuntium/features/home/presentation/model/article.dart';

part 'bookmark_db_model.g.dart';

@HiveType(typeId: 1)
class BookmarkModel {
  @HiveField(0)
  late final String title;

  @HiveField(1)
  late final String url;

  @HiveField(2)
  late final String? imageUrl;

  // you must provide empty constructor
  // so hive can generate(serializable) object
  // so you u can store this object in local db (hive)
  BookmarkModel();

  BookmarkModel.fromData({
    required this.title,
    required this.url,
    required this.imageUrl,
  });

  Article toArticle() {
    return Article(
      isSaved: false,
      author: null,
      publishedAt: null,
      content: null,
      imageUrl: imageUrl,
      url: url,
      description: null,
      title: title,
    );
  }
}
