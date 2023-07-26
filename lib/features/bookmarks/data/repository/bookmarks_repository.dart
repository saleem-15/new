import 'package:dartz/dartz.dart';
import 'package:nuntium/core/error_handler/error_handler.dart';

import 'package:nuntium/core/storage/local/model/article_model.dart';
import 'package:nuntium/features/bookmarks/data/data_source/local_bookmarks_data_source.dart';

abstract class BookmarksRepository {
  Either<Failure, List<Article>> getBookmarks();
  Future<Either<Failure, void>> addBookmark(Article bookmark);
  Future<Either<Failure, void>> deleteBookmark(Article bookmark);
}

class BookmarksRepositoryImplement implements BookmarksRepository {
  final LocalBookmarksDataSource _localBookmarksDataSource;

  BookmarksRepositoryImplement(this._localBookmarksDataSource);

  @override
  Either<Failure, List<Article>> getBookmarks() {
    try {
      final bookmarks = _localBookmarksDataSource.getBookmarks();

      return Right(bookmarks);
    } catch (e) {
      return Left(
        ErrorHandler.handle(e).failure,
      );
    }
  }

  @override
  Future<Either<Failure, void>> addBookmark(Article bookmark) async {
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
  Future<Either<Failure, void>> deleteBookmark(Article bookmark) async {
    try {
      await _localBookmarksDataSource.deleteBookmark(bookmark);
      return const Right(null);
    } catch (e) {
      return Left(
        ErrorHandler.handle(e).failure,
      );
    }
  }
}
