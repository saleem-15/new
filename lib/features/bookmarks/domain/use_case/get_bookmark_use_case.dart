import 'package:dartz/dartz.dart';
import 'package:nuntium/core/error_handler/error_handler.dart';
import 'package:nuntium/core/use_case/base_usecase.dart';
import 'package:nuntium/features/bookmarks/data/repository/bookmarks_repository.dart';
import 'package:nuntium/core/storage/local/model/article_model.dart';

class ViewBookmarksUseCase implements BaseOutUseCase<List<Article>> {
  final BookmarksRepository _bookmarkRepository;

  ViewBookmarksUseCase(this._bookmarkRepository);

  @override
  Future<Either<Failure, List<Article>>> execute() async {
    return _bookmarkRepository.getBookmarks();
  }
}
