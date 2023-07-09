import 'package:dartz/dartz.dart';
import 'package:nuntium/core/error_handler/error_handler.dart';
import 'package:nuntium/core/storage/local/model/bookmark_db_model.dart';
import 'package:nuntium/core/use_case/base_usecase.dart';
import 'package:nuntium/features/bookmarks/data/repository/bookmarks_repository.dart';

class ViewBookmarksUseCase implements BaseOutUseCase<List<BookmarkModel>> {
  final BookmarksRepository _bookmarkRepository;

  ViewBookmarksUseCase(this._bookmarkRepository);

  @override
  Future<Either<Failure, List<BookmarkModel>>> execute() async {
    return _bookmarkRepository.getBookmarks();
  }
}
