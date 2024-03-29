import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hostel_nepal/constants/dimensions.dart';
import 'package:hostel_nepal/constants/utils.dart';

import '../../../../../common/app_style.dart';
import '../controller/forget_password_controller.dart';
import '../widget/loader_button.dart';
import 'otp_screen.dart';

class ForgetPassword extends ConsumerStatefulWidget {
  static const String routeName = '/forgot-password-screen';

  const ForgetPassword({Key? key}) : super(key: key);

  @override
  ConsumerState<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends ConsumerState<ForgetPassword> {
  final TextEditingController emailController = TextEditingController();

  void getResponseOfForgetPassword() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              SizedBox(width: Dimensions.width20),
              const Text("Loading, please wait..."),
            ],
          ),
        );
      },
    );
    List<dynamic> data = await ref
        .read(forgetPasswordControllerProvider)
        .forgetPassword(context: context, email: emailController.text);
    if (!context.mounted) return;
    Navigator.pop(context);
    if (data[0]) {
      Navigator.pushNamed(context, OTPScreen.routeName, arguments: {
        "email": emailController.text,
        "otpCode": data[1],
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Forgot Password',
          style: appStyle(Dimensions.font18, Colors.white, FontWeight.normal),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.width20,
            vertical: Dimensions.height50,
          ),
          child: Column(
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: Dimensions.height50),
              LoaderButton(
                onTap: () {
                  if (emailController.text.isEmpty) {
                    showSnackBar(context, "Please enter your Email");
                  } else {
                    getResponseOfForgetPassword();
                  }
                },
                text: 'Reset Password',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
