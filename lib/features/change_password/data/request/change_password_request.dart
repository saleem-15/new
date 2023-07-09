class ChangePasswordRequest {
  String currentPassword;
  String newPassword;

  ChangePasswordRequest({
    required this.newPassword,
    required this.currentPassword,
  });
}
