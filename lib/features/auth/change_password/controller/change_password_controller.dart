import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/change_password_repository.dart';

final changePasswordControllerProvider = Provider((ref) {
  final changePasswordRepository = ref.read(changePasswordRepositoryProvider);
  return ChangePasswordController(
      changePasswordRepository: changePasswordRepository, ref: ref);
});

class ChangePasswordController {
  final ChangePasswordRepository changePasswordRepository;
  final ProviderRef ref;

  ChangePasswordController({
    required this.changePasswordRepository,
    required this.ref,
  });

  void changePassword({
    required String oldPassword,
    required String newPassword,
    required BuildContext context,
  }) {
    changePasswordRepository.changePassword(
        context: context, oldPassword: oldPassword, newPassword: newPassword);
  }
}
