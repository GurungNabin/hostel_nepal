import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/forget_password_repository.dart';

final forgetPasswordControllerProvider = Provider((ref) {
  final forgetPasswordRepository = ref.read(forgetPasswordRepositoryProvider);
  return ForgetPasswordController(
      ref: ref, forgetPasswordRepository: forgetPasswordRepository);
});

class ForgetPasswordController {
  final ProviderRef ref;
  final ForgetPasswordRepository forgetPasswordRepository;

  ForgetPasswordController(
      {required this.ref, required this.forgetPasswordRepository});

  Future<dynamic> forgetPassword(
      {required BuildContext context, required String email}) {
    return forgetPasswordRepository.forgetPassword(
        context: context, email: email);
  }

  void changeForgetPassword(
      {required BuildContext context,
      required String email,
      required String password}) {
    return forgetPasswordRepository.changeForgetPassword(
        context: context, email: email, password: password);
  }
}
