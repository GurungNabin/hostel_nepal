import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hostel_nepal/constants/error_handleing.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/global_variables.dart';
import '../../../../constants/utils.dart';

final changePasswordRepositoryProvider =
    Provider((ref) => ChangePasswordRepository(ref: ref));

class ChangePasswordRepository {
  final ProviderRef ref;

  ChangePasswordRepository({required this.ref});

  void changePassword({
    required BuildContext context,
    required String oldPassword,
    required String newPassword,
  }) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String? token = sharedPreferences.getString('x-auth-token');
    try {
      http.Response res = await http.put(
        Uri.parse('$uri/changepassword'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
          //'key': apiKey,
        },
        body: jsonEncode({
          "oldpassword": oldPassword,
          "newpassword": newPassword,
        }),
      );
      print("The status code is ${res.statusCode}");
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, "Successfully changed your password!");
            Navigator.pop(context);
          });
    } catch (e) {
      print("err in change password service");
    }
  }
}
