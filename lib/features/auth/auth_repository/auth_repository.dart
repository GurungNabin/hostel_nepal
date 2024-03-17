// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:hostel_nepal/features/user/userModel/user_model.dart';
// import 'package:hostel_nepal/member.dart';
// import 'package:hostel_nepal/utils.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';


// import '../auth_controller/auth_controller.dart';
// import '../screens/login_screen.dart';

// final authRepositoryProvider = Provider((ref) => AuthRepository(ref: ref));

// class AuthRepository {
//   final ProviderRef ref;

//   AuthRepository({required this.ref});

//   void signUpUser({
//     required BuildContext context,
//     required String email,
//     required String password,
//     required String phoneNumber,
//     required String username,
//   }) async {
//     try {
//       http.Response res = await http.post(
//         Uri.parse('$uri/register'),
//         body: jsonEncode({
//           'username': username,
//           'password': password,
//           'phonenumber': phoneNumber,
//           'email': email,
//         }),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//       );
//       if (!context.mounted) return;
//       httpErrorHandle(
//         response: res,
//         context: context,
//         onSuccess: () {
//           showSnackBar(
//             context,
//             'Account created! Login with the same credentials!',
//           );
//           Navigator.pop(context);
//         },
//       );
//     } catch (e) {
//       showSnackBar(context, "Cannot create an new account");
//     }
//   }

//   void signInUser({
//     required BuildContext context,
//     required String email,
//     required String password,
//   }) async {
//     // UserModel? userModel;
//     try {
//       http.Response res = await http.post(
//         Uri.parse('$uri/login'),
//         body: jsonEncode({'email': email, 'password': password}),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//       );
//       print('Hello error');
//       if (!context.mounted) return;
//       httpErrorHandle(
//           response: res,
//           context: context,
//           onSuccess: () async {
//             ref
//                 .read(userDataProvider.notifier)
//                 .update((state) => userModelFromJson(res.body));
//             showSnackBar(context, "Successfully logged in!");
//             SharedPreferences prefs = await SharedPreferences.getInstance();
//             await prefs.setString(
//                 'x-auth-token', jsonDecode(res.body)['token']);
//             if (!context.mounted) return;
//             Navigator.pushNamedAndRemoveUntil(
//                 context, Member.routeName, (route) => false);
//           });
//     } catch (e) {
//       print("err in sign in user");
//     }
//   }

//   //logout
//   //log out method
//   void logOut(BuildContext context) async {
//     try {
//       SharedPreferences sharedPreferences =
//           await SharedPreferences.getInstance();
//       await sharedPreferences.setString('x-auth-token', "");
//       if (!context.mounted) return;
//       Navigator.pushNamedAndRemoveUntil(
//           context, LoginScreen.routeName, (route) => false);
//       ref.read(userDataProvider.notifier).state = null;
//     } catch (e) {
//       showSnackBar(context, e.toString());
//     }
//   }

//   Future<bool> getUserData(ProviderRef ref) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? token = prefs.getString('x-auth-token');
//     try {
//       if (token == null) {
//         await prefs.setString('x-auth-token', '');
//         return false;
//       } else {
//         var tokenRes = await http.post(Uri.parse('$uri/get_user_data'),
//             headers: <String, String>{
//               'Content-Type': 'application/json; charset=UTF-8',
//               'x-auth-token': token
//             });
//         if (tokenRes.statusCode == 200) {
//           ref
//               .watch(userDataProvider.notifier)
//               .update((state) => userModelFromJson(tokenRes.body));
//           return true;
//         } else {
//           return false;
//         }
//       }
//     } catch (e) {
//       print("Program failed on get user data on catch");
//       return false;
//     }
//   }
// }
