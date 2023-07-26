import 'package:hive/hive.dart';

part 'article_model.g.dart';

@HiveType(typeId: 2)
class Article {
  @HiveField(0)
  late String? author;

  @HiveField(1)
  late String? url;

  @HiveField(2)
  late String? imageUrl;

  @HiveField(3)
  late String? title;

  @HiveField(4)
  late String? publishedAt;

  @HiveField(5)
  late String? content;

  @HiveField(6)
  late String? description;

  @HiveField(7)
  late bool isSaved;

  // you must provide empty constructor
  // so hive can generate(serializable) object
  // so you u can store this object in local db (hive)
  Article();

  Article.fromData({
    required this.isSaved,
    required this.author,
    required this.publishedAt,
    required this.content,
    required this.imageUrl,
    required this.url,
    required this.description,
    required this.title,
  });

  /// returnes the text that should be displayed
  String get displayText {
    return title ?? description ?? content ?? '';
  }
}
