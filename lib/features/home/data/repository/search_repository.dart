import 'package:dartz/dartz.dart';
import 'package:get/get.dart';

import 'package:nuntium/core/error_handler/error_handler.dart';
import 'package:nuntium/core/error_handler/response_code.dart';
import 'package:nuntium/core/internet_checker/internet_checker.dart';
import 'package:nuntium/core/resorces/manager_strings.dart';
import 'package:nuntium/features/home/data/mapper/search_response_mapper.dart';

import '../../domain/entity/search_entity.dart';
import '../data_source/remote_search_data_source.dart';
import '../request/search_request.dart';

abstract class SearchRepository {
  Future<Either<Failure, SearchEntity>> search(SearchRequest searchRequest);
}

class SearchRepositoryImpl implements SearchRepository {
  final RemoteSearchDataSource _remoteSearchDataSource;
  final NetworkInfo _networkInfo;

  SearchRepositoryImpl(
    this._remoteSearchDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, SearchEntity>> search(SearchRequest searchRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        final search = await _remoteSearchDataSource.search(searchRequest);
        return Right(search.toDomain());
      } on Exception catch (e) {
        e.printError();
        return Left(
          ErrorHandler.handle(e).failure,
        );
      }
    } else {
      return Left(
        Failure(
          ResponseCode.NO_INTERNET_CONNECTION.value,
          ManagerStrings.noInternetConnection,
        ),
      );
    }
  }
}
