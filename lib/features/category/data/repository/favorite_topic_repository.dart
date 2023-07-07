import 'package:dartz/dartz.dart';
import 'package:nuntium/core/error_handler/error_handler.dart';

import 'package:nuntium/core/error_handler/response_code.dart';
import 'package:nuntium/core/internet_checker/internet_checker.dart';
import 'package:nuntium/core/resorces/manager_strings.dart';
import 'package:nuntium/features/category/data/data_source/local_favorite_topic_data_source.dart';
import 'package:nuntium/features/category/data/request/favorite_topic_request.dart';

abstract class FavoriteTopicRepository {
  Future<Either<Failure, void>> selectFavoriteTopic(SelectFavoriteTopicRequest verifyCode);
}

class FavoriteTopicRepositoryImplement implements FavoriteTopicRepository {
  final LocalFavoriteTopicDataSource _localFavoriteTopicDataSource;
  final NetworkInfo _networkInfo;

  FavoriteTopicRepositoryImplement(
    this._localFavoriteTopicDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, void>> selectFavoriteTopic(
      SelectFavoriteTopicRequest selectFavoriteTopicRequest) async {
    if (await _networkInfo.isConnected) {
      await _localFavoriteTopicDataSource.selectFavoriteTopic();
      return const Right(null);
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
