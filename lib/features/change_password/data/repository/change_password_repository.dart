import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nuntium/core/error_handler/error_handler.dart';
import 'package:nuntium/core/error_handler/response_code.dart';
import 'package:nuntium/core/internet_checker/internet_checker.dart';
import 'package:nuntium/core/resorces/manager_strings.dart';
import '../data_source/remote_change_password_data_source.dart';
import '../request/change_password_request.dart';

abstract class ChangePasswordRepository {
  Future<Either<Failure, void>> changePassword(ChangePasswordRequest changePasswordRequest);
}

class ChangePasswordRepositoryImpl implements ChangePasswordRepository {
  final RemoteChangePasswordDataSource _remoteLoginDataSource;
  final NetworkInfo _networkInfo;

  ChangePasswordRepositoryImpl(
    this._remoteLoginDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, void>> changePassword(ChangePasswordRequest changePasswordRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        return Right(
          await _remoteLoginDataSource.changePassword(changePasswordRequest),
        );
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
