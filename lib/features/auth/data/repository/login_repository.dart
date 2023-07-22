import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nuntium/core/error_handler/error_handler.dart';
import 'package:nuntium/core/error_handler/response_code.dart';
import 'package:nuntium/core/internet_checker/internet_checker.dart';
import 'package:nuntium/core/resorces/manager_strings.dart';
import 'package:nuntium/features/auth/data/data_source/remote_login_data_source.dart';
import 'package:nuntium/features/auth/data/request/login_request.dart';
import 'package:nuntium/features/auth/data/response/login_response.dart';

import '../data_source/remote_login_with_google_data_source.dart';

abstract class LoginRepository {
  Future<Either<Failure, LoginResponse>> login(LoginRequest loginRequest);

  Future<Either<Failure, LoginResponse>> loginWithGoogle();
}

class LoginRepositoryImplement implements LoginRepository {
  final RemoteLoginDataSource _remoteLoginDataSource;
  final RemoteLoginWithGoogleDataSource _remoteLoginWithGoogleDataSource;
  final NetworkInfo _networkInfo;

  LoginRepositoryImplement(
    this._remoteLoginDataSource,
    this._remoteLoginWithGoogleDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, LoginResponse>> login(LoginRequest loginRequest) async {
    if (await _networkInfo.isConnected) {
      try {
        return Right(await _remoteLoginDataSource.login(loginRequest));
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

  @override
  Future<Either<Failure, LoginResponse>> loginWithGoogle() async {
    if (await _networkInfo.isConnected) {
      try {
        return Right(await _remoteLoginWithGoogleDataSource.login());
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
