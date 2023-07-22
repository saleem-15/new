import 'package:dartz/dartz.dart';
import 'package:nuntium/core/error_handler/error_handler.dart';
import 'package:nuntium/core/use_case/base_usecase.dart';
import 'package:nuntium/features/auth/data/repository/logout_repository.dart';

class LogoutUseCase implements BaseVoidUseCase {
  final LogoutRepository _logoutRepository;

  LogoutUseCase(this._logoutRepository);

  @override
  Future<Either<Failure, void>> execute() async {
    return await _logoutRepository.logout();
  }
}
