import 'package:dartz/dartz.dart';
import 'package:nuntium/core/error_handler/error_handler.dart';
import 'package:nuntium/core/use_case/base_usecase.dart';
import 'package:nuntium/features/auth/data/response/login_response.dart';

import '../../data/repository/login_repository.dart';

class LoginWithGoogleUseCase implements BaseOutUseCase<LoginResponse> {
  final LoginRepository _loginRepository;

  LoginWithGoogleUseCase(this._loginRepository);

  @override
  Future<Either<Failure, LoginResponse>> execute() async {
    return await _loginRepository.loginWithGoogle();
  }
}
