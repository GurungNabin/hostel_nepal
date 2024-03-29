import 'package:flutter/material.dart';
import 'package:hostel_nepal/features/auth/forget_passowrd/screen/change_forget_password.dart';
import 'package:hostel_nepal/features/auth/forget_passowrd/screen/forget_password_screen.dart';
import 'package:hostel_nepal/features/auth/auth_screens/login_screen.dart';
import 'package:hostel_nepal/features/auth/auth_screens/sign_up_screen.dart';
import 'package:hostel_nepal/member.dart';


Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case SignupScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const SignupScreen());

    case LoginScreen.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const LoginScreen());

    case Member.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const Member());

    case ChangeForgetPassword.routeName:
      final argument = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => ChangeForgetPassword(
          email: argument,
        ),
      );

    case ForgetPassword.routeName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const ForgetPassword());

    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text("Screen Doesn't exist"),
          ),
        ),
      );
  }
}
