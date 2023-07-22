import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nuntium/core/error_handler/error_handler.dart';
import 'package:nuntium/core/error_handler/response_code.dart';
import 'package:nuntium/core/internet_checker/internet_checker.dart';
import 'package:nuntium/core/resorces/manager_strings.dart';

import '../data_source/remote_logout_data_source.dart';

abstract class LogoutRepository {
  Future<Either<Failure, void>> logout();
}

class LogoutRepositoryImpl implements LogoutRepository {
  final RemoteLogoutDataSource _remoteLogoutDataSource;
  final NetworkInfo _networkInfo;

  LogoutRepositoryImpl(
    this._remoteLogoutDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, void>> logout() async {
    if (await _networkInfo.isConnected) {
      try {
        return Right(await _remoteLogoutDataSource.logout());
      } on FirebaseAuthException catch (e) {
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
