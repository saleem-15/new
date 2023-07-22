import 'package:dartz/dartz.dart';
import 'package:nuntium/core/error_handler/error_handler.dart';
import 'package:nuntium/core/use_case/base_usecase.dart';

import '../../data/repository/search_repository.dart';
import '../../data/request/search_request.dart';
import '../entity/search_entity.dart';

class SearchUseCaseInput {
  String search;
  int page;
  int pageSize;
  String? country;
  String? category;
  String? sources;

  SearchUseCaseInput({
    required this.search,
    required this.page,
    required this.pageSize,
    this.country,
    this.category,
    this.sources,
  });
}

class SearchUseCase implements BaseUseCase<SearchUseCaseInput, SearchEntity> {
  final SearchRepository _searchRepository;

  SearchUseCase(this._searchRepository);

  @override
  Future<Either<Failure, SearchEntity>> execute(SearchUseCaseInput input) async {
    return _searchRepository.search(
      SearchRequest(
        page: input.page,
        pageSize: input.pageSize,
        category: input.category,
        country: input.country,
        search: input.search,
        sources: input.sources,
      ),
    );
  }
}
