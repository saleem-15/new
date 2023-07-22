import 'package:dartz/dartz.dart';
import 'package:nuntium/core/error_handler/error_handler.dart';
import 'package:nuntium/core/storage/local/model/bookmark_db_model.dart';
import 'package:nuntium/core/use_case/base_usecase.dart';
import 'package:nuntium/features/bookmarks/data/repository/bookmarks_repository.dart';

class DeleteBookmarkUseCaseInput {
  BookmarkModel bookmark;

  DeleteBookmarkUseCaseInput({required this.bookmark});
}

class DeleteBookmarkUseCase implements BaseInUseCase<DeleteBookmarkUseCaseInput> {
  final BookmarksRepository _bookmarkRepository;

  DeleteBookmarkUseCase(this._bookmarkRepository);

  @override
  Future<Either<Failure, void>> execute(DeleteBookmarkUseCaseInput input) async {
    return await _bookmarkRepository.deleteBookmark(input.bookmark);
  }
}
