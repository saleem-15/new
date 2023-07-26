import 'package:dartz/dartz.dart';
import 'package:nuntium/core/error_handler/error_handler.dart';
import 'package:nuntium/core/storage/local/model/article_model.dart';
import 'package:nuntium/core/use_case/base_usecase.dart';
import 'package:nuntium/features/bookmarks/data/repository/bookmarks_repository.dart';

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
      input.article,
    );
  }
}
