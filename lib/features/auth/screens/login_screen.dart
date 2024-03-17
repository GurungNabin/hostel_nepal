// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:hostel_nepal/common/custom_button.dart';
// import 'package:hostel_nepal/common/custom_textfield.dart';
// import 'package:hostel_nepal/common/password_textfield.dart';
// import 'package:hostel_nepal/media_query/size_config.dart';
// import 'package:hostel_nepal/utils.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   static const String routeName = '/login-screen';

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _signInFormKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool isLoading = false;

//   Future<void> login(String email, String password) async {
//     setState(() {
//       isLoading = true;
//     });
//     try {
//       showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             content: Row(
//               children: [
//                 const CircularProgressIndicator(),
//                 SizedBox(width: ScreenUtil.blockSizeHorizontal),
//                 const Text(
//                   'Logging in...',
//                   style: TextStyle(
//                       fontSize: 12,
//                       color: Colors.black87,
//                       fontWeight: FontWeight.normal),
//                 ),
//               ],
//             ),
//           );
//         },
//       );
//       await Future.delayed(const Duration(seconds: 1));
//       if (!context.mounted) return;
//       ref
//           .read(authControllerProvider)
//           .loginUser(context: context, email: email, password: password);
//       Navigator.of(context, rootNavigator: true).pop();
//     } catch (error) {
//       Navigator.of(context, rootNavigator: true).pop();
//       showSnackBar(context, "Login failed. Please check your credentials.");
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Initialize ScreenUtil
//     ScreenUtil.init(context);

//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.only(
//               left: ScreenUtil.blockSizeHorizontal * 5,
//               right: ScreenUtil.blockSizeHorizontal * 5,
//               top: ScreenUtil.blockSizeVertical,
//             ),
//             child: Form(
//               key: _signInFormKey,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   const Text(
//                     'Login with your Account',
//                     style: TextStyle(
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black87,
//                       fontSize: 24,
//                     ),
//                   ),
//                   SizedBox(
//                     height: ScreenUtil.blockSizeVertical *
//                         5, // Example usage of ScreenUtil for spacing
//                   ),
//                   CustomTextField(
//                     controller: _emailController,
//                     hintText: 'Email',
//                   ),
//                   SizedBox(
//                     height: ScreenUtil.blockSizeVertical *
//                         3, // Example usage of ScreenUtil for spacing
//                   ),
//                   PasswordTextField(
//                     controller: _passwordController,
//                     label: 'Password',
//                     hintText: 'Password',
//                     obText: true,
//                   ),
//                   SizedBox(
//                     height: ScreenUtil.blockSizeVertical *
//                         3, // Example usage of ScreenUtil for spacing
//                   ),
//                   CustomButton(
//                     text: "Log in",
//                     onTap: () async {
//                       if (_signInFormKey.currentState!.validate()) {
//                         if (_passwordController.text.length < 6) {
//                           showSnackBar(
//                               context, "Please enter a longer password");
//                         } else {
//                           final connectivityResult =
//                               await (Connectivity().checkConnectivity());
//                           if (connectivityResult == ConnectivityResult.none) {
//                             if (!context.mounted) return;
//                             showSnackBar(context,
//                                 "No internet Connection, Please try again!");
//                           } else {
//                             login(_emailController.text,
//                                 _passwordController.text);
//                             print('earth');
//                           }
//                         }
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
