import 'package:hive/hive.dart';

part 'bookmark_db_model.g.dart';

@HiveType(typeId: 1)
class BookmarkModel {
  @HiveField(0)
  late final String title;

  @HiveField(2)
  late final String imageUrl;

  // you must provide empty constructor
  // so hive can generate(serializable) object
  // so you u can store this object in local db (hive)
  BookmarkModel();

  BookmarkModel.fromData({
    required this.title,
    required this.imageUrl,
  });
}
