import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hostel_nepal/constants/dimensions.dart';
import 'package:hostel_nepal/constants/utils.dart';

import '../../../../../common/app_style.dart';
import '../../../../../common/custom_button.dart';
import '../../../../../common/password_textfield.dart';
import '../controller/forget_password_controller.dart';

class ChangeForgetPassword extends ConsumerStatefulWidget {
  static const String routeName = '/change-forgot-password';
  final String email;

  const ChangeForgetPassword({super.key, required this.email});

  @override
  ConsumerState<ChangeForgetPassword> createState() =>
      _ChangeForgetPasswordState();
}

class _ChangeForgetPasswordState extends ConsumerState<ChangeForgetPassword> {
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  void changeForgetPassword({required String email, required String password}) {
    ref.read(forgetPasswordControllerProvider).changeForgetPassword(
        context: context, email: email, password: password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Change Password',
          style: appStyle(18, Colors.white, FontWeight.normal),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.width20, vertical: Dimensions.height50),
          child: Column(
            children: [
              PasswordTextField(
                  controller: newPasswordController,
                  label: 'New Password',
                  hintText: 'New Password',
                  obText: true),
              SizedBox(height: Dimensions.height35),
              PasswordTextField(
                  controller: confirmPasswordController,
                  label: 'Confirm Password',
                  hintText: 'Confirm Password',
                  obText: true),
              SizedBox(height: Dimensions.height40),
              CustomButton(
                  text: 'Change Password',
                  onTap: () {
                    if (newPasswordController.text.isEmpty &&
                        confirmPasswordController.text.isEmpty) {
                      showSnackBar(context, "Please enter all the fields");
                    } else if (confirmPasswordController.text !=
                        newPasswordController.text) {
                      showSnackBar(
                          context, "New and Confirm password didn't matched");
                    } else if (newPasswordController.text.length < 6 &&
                        confirmPasswordController.text.length < 6) {
                      showSnackBar(context, "Please enter longer password");
                    } else {
                      changeForgetPassword(
                          email: widget.email,
                          password: newPasswordController.text.trim());
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
