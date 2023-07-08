import 'package:dartz/dartz.dart';
import 'package:nuntium/core/error_handler/error_handler.dart';

import 'package:nuntium/core/storage/local/model/bookmark_db_model.dart';
import 'package:nuntium/features/bookmarks/data/data_source/local_bookmarks_data_source.dart';

abstract class BookmarksRepository {
  Future<Either<Failure, void>> addBookmark(BookmarkModel bookmark);
  Either<Failure, List<BookmarkModel>> getBookmarks();
}

class BookmarksRepositoryImplement implements BookmarksRepository {
  final LocalBookmarksDataSource _localBookmarksDataSource;

  BookmarksRepositoryImplement(this._localBookmarksDataSource);

  @override
  Future<Either<Failure, void>> addBookmark(BookmarkModel bookmark) async {
    try {
      await _localBookmarksDataSource.addBookmark(bookmark);
      return const Right(null);
    } catch (e) {
      return Left(
        ErrorHandler.handle(e).failure,
      );
    }
  }

  @override
  Either<Failure, List<BookmarkModel>> getBookmarks()  {
    try {
      final bookmarks = _localBookmarksDataSource.getBookmarks();

      return Right(bookmarks);
    } catch (e) {
      return Left(
        ErrorHandler.handle(e).failure,
      );
    }
  }
}
