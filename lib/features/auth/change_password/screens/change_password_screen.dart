import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/custom_button.dart';
import '../../../../common/password_textfield.dart';
import '../../../../constants/dimensions.dart';
import '../../../../constants/utils.dart';
import '../controller/change_password_controller.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  static const String routeName = '/change-password-screen';

  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _changePasswordFormKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _reTypePasswordController = TextEditingController();

  void changePassword() {
    ref.read(changePasswordControllerProvider).changePassword(
        context: context,
        oldPassword: _oldPasswordController.text.trim(),
        newPassword: _newPasswordController.text.trim());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _newPasswordController.dispose();
    _oldPasswordController.dispose();
    _reTypePasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Change Password")),
      body: Container(
        height: Dimensions.screenHeight,
        width: Dimensions.screenWidth,
        padding: const EdgeInsets.all(15).w,
        child: SingleChildScrollView(
          child: Form(
            key: _changePasswordFormKey,
            child: Column(
              children: [
                PasswordTextField(
                    controller: _oldPasswordController,
                    label: "Current Password",
                    hintText: "Current Password",
                    obText: true),
                SizedBox(
                  height: 15.h,
                ),
                PasswordTextField(
                    controller: _newPasswordController,
                    label: "New Password",
                    hintText: "New Password",
                    obText: true),
                SizedBox(
                  height: Dimensions.height15,
                ),
                PasswordTextField(
                    controller: _reTypePasswordController,
                    label: "Re-type New Password",
                    hintText: "Re-type New Password",
                    obText: true),
                SizedBox(
                  height: Dimensions.height80,
                ),
                CustomButton(
                    text: "Change Password",
                    onTap: () {
                      if (_changePasswordFormKey.currentState!.validate()) {
                        if (_newPasswordController.text.length < 6 ||
                            _reTypePasswordController.text.length < 6) {
                          showSnackBar(
                              context, "Password length is less than 6!");
                        } else {
                          if (_newPasswordController.text ==
                              _reTypePasswordController.text) {
                            changePassword();
                          } else {
                            showSnackBar(context,
                                "New password and Re-typed password didn't matched!!");
                          }
                        }
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
