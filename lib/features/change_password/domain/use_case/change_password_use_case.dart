import 'package:dartz/dartz.dart';
import 'package:nuntium/core/error_handler/error_handler.dart';
import 'package:nuntium/core/use_case/base_usecase.dart';
import '../../data/repository/change_password_repository.dart';
import '../../data/request/change_password_request.dart';

class ChangePasswordUseCaseInput {
  String currentPassword;
  String newPassword;

  ChangePasswordUseCaseInput({
    required this.newPassword,
    required this.currentPassword,
  });
}

class ChangePasswordUseCase implements BaseInUseCase<ChangePasswordUseCaseInput> {
  final ChangePasswordRepository _changePasswordRepository;

  ChangePasswordUseCase(this._changePasswordRepository);

  @override
  Future<Either<Failure, void>> execute(ChangePasswordUseCaseInput input) async {
    return await _changePasswordRepository.changePassword(
      ChangePasswordRequest(
        currentPassword: input.currentPassword,
        newPassword: input.newPassword,
      ),
    );
  }
}
