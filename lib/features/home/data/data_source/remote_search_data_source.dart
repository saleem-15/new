import 'package:nuntium/core/network/app_api.dart';

import '../request/search_request.dart';
import '../response/search_response.dart';

abstract class RemoteSearchDataSource {
  Future<SearchResopnse> search(SearchRequest searchRequest);
}

class RemoteSearchDataSourceImpl implements RemoteSearchDataSource {
  final AppApi _appApi;

  RemoteSearchDataSourceImpl(
    this._appApi,
  );

  @override
  Future<SearchResopnse> search(SearchRequest searchRequest) async {
    return await _appApi.search(
      searchRequest.search,
      searchRequest.page,
      searchRequest.pageSize,
      searchRequest.country,
      searchRequest.category,
      searchRequest.sources,
    );
  }
}
