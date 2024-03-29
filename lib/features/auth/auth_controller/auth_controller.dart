import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hostel_nepal/features/auth/auth_repo/auth_repo.dart';
import 'package:hostel_nepal/features/userModel/user_model.dart';


final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(ref: ref, authRepository: authRepository);
});

final userDataProvider = StateProvider<UserModel?>((ref) => null);

class AuthController {
  final AuthRepository authRepository;
  final ProviderRef ref;

  AuthController({required this.ref, required this.authRepository});

  void signUp({
    required BuildContext context,
    required String email,
    required String password,
    required String phone,
    required String name,
  }) {
    authRepository.signUpUser(
        context: context,
        email: email,
        password: password,
        phone: phone,
        name: name);
  }

  void loginUser(
      {required BuildContext context,
      required String email,
      required String password}) {
    authRepository.signInUser(
        context: context, email: email, password: password);
  }

  Future<bool> getUserData() async {
    return await authRepository.getUserData(ref);
  }

  void logOutUser(BuildContext context) {
    authRepository.logOut(context);
  }
}
