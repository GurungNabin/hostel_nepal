// import 'package:flutter/cupertino.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hostel_nepal/features/user/userModel/user_model.dart';

// import '../auth_repository/auth_repository.dart';

// final authControllerProvider = Provider((ref) {
//   final authRepository = ref.watch(authRepositoryProvider);
//   return AuthController(ref: ref, authRepository: authRepository);
// });

// final userDataProvider = StateProvider<UserModel?>((ref) => null);

// class AuthController {
//   final AuthRepository authRepository;
//   final ProviderRef ref;

//   AuthController({required this.ref, required this.authRepository});

//   void signUp({
//     required BuildContext context,
//     required String email,
//     required String password,
//     required String phoneNumber,
//     required String username,
    
//   }) {
//     authRepository.signUpUser(
//         context: context,
//         email: email,
//         password: password,
//         phoneNumber: phoneNumber,
//         username: username);
//   }

//   void loginUser(
//       {required BuildContext context,
//       required String email,
//       required String password}) {
//     authRepository.signInUser(
//         context: context, email: email, password: password);
//   }

//   Future<bool> getUserData() async {
//     return await authRepository.getUserData(ref);
//   }

//   void logOutUser(BuildContext context) {
//     authRepository.logOut(context);
//   }
// }
