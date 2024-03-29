import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hostel_nepal/constants/error_handleing.dart';
import 'package:hostel_nepal/constants/global_variables.dart';
import 'package:hostel_nepal/constants/utils.dart';
import 'package:http/http.dart' as http;

import '../../auth_screens/login_screen.dart';

final forgetPasswordRepositoryProvider =
    Provider((ref) => ForgetPasswordRepository());

class ForgetPasswordRepository {
  Future<List<dynamic>> forgetPassword({
    required BuildContext context,
    required String email,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/forgetpassword'),
        body: jsonEncode({'email': email}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          //'key': apiKey,
        },
      );
      if (res.statusCode == 200) {
        String code = jsonDecode(res.body)['token'];
        return [true, code];
      } else if (res.statusCode == 400) {
        showSnackBar(context, jsonDecode(res.body)['msg']);
        return [false];
      } else {
        showSnackBar(context, "Please try again");
        return [false];
      }
    } catch (e) {
      return [false];
    }
  }

  void changeForgetPassword({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/forgetpassword'),
        body: jsonEncode({'email': email, 'newpassword': password}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          //'key': apiKey,
        },
      );
      if (context.mounted) return;
      print(res.statusCode);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          if (res.statusCode == 200) {
            showSnackBar(context, "Successfully changed password");
            Navigator.pushNamedAndRemoveUntil(
                context, LoginScreen.routeName, (route) => false);
          } else {
            showSnackBar(context, "Please try again later!");
          }
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
