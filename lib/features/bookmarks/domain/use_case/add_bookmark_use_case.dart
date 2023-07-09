import 'package:dartz/dartz.dart';
import 'package:nuntium/core/error_handler/error_handler.dart';
import 'package:nuntium/core/storage/local/model/bookmark_db_model.dart';
import 'package:nuntium/core/use_case/base_usecase.dart';
import 'package:nuntium/features/bookmarks/data/repository/bookmarks_repository.dart';
import 'package:nuntium/features/home/presentation/model/article.dart';

class AddBookmarkUseCaseInput {
  Article article;

  AddBookmarkUseCaseInput({required this.article});
}

class AddBookmarkUseCase implements BaseInUseCase<AddBookmarkUseCaseInput> {
  final BookmarksRepository _bookmarkRepository;

  AddBookmarkUseCase(this._bookmarkRepository);

  @override
  Future<Either<Failure, void>> execute(AddBookmarkUseCaseInput input) async {
    return await _bookmarkRepository.addBookmark(
      BookmarkModel.fromData(
        imageUrl: input.article.imageUrl!,
        title: input.article.title!,
      ),
    );
  }
}
