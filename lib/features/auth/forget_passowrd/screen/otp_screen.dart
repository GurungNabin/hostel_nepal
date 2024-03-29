import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hostel_nepal/constants/dimensions.dart';
import 'package:hostel_nepal/constants/utils.dart';


import '../../../../../common/app_style.dart';
import '../widget/loader_button.dart';
import 'change_forget_password.dart';

class OTPScreen extends StatefulWidget {
  static const String routeName = '/otp-screen';
  final String otpCode;
  final String email;

  const OTPScreen({super.key, required this.otpCode, required this.email});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final TextEditingController otpController = TextEditingController();
  int remainingTimeInSeconds = 120; // 2 minutes in seconds
  late Timer _countdownTimer;
  bool timerExpired = false;

  @override
  void initState() {
    super.initState();
    startCountdownTimer();
  }

  void startCountdownTimer() {
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTimeInSeconds > 0) {
          remainingTimeInSeconds--;
        } else {
          _countdownTimer.cancel();
          timerExpired = true;
        }
      });
    });
  }

  void verifyOTP({required String email}) {
    _countdownTimer.cancel(); // Cancel the timer before navigation
    Navigator.pushNamed(context, ChangeForgetPassword.routeName,
        arguments: widget.email);
  }

  @override
  void dispose() {
    _countdownTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verifying OTP Code'),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: Dimensions.height100),
            Text(
              'We have sent an Email with a code.',
              style:
                  appStyle(Dimensions.font20, Colors.black, FontWeight.normal),
            ),
            SizedBox(
              width: Dimensions.screenWidth - Dimensions.width100,
              child: TextField(
                controller: otpController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: '- - - - - -',
                  hintStyle: TextStyle(
                    fontSize: Dimensions.font25 * 2,
                  ),
                ),
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  if (val.length == 6) {
                    if (widget.otpCode == val.trim()) {
                      verifyOTP(email: widget.email);
                    } else {
                      otpController.clear();
                      showSnackBar(context, "Your Code is incorrect");
                    }
                  }
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            if (!timerExpired)
              Text(
                  'Time remaining: ${remainingTimeInSeconds ~/ 60}:${remainingTimeInSeconds % 60}',
                  style: appStyle(
                      Dimensions.font14, Colors.black45, FontWeight.bold)),
            if (timerExpired)
              LoaderButton(
                  text: 'Resend Email',
                  onTap: () {
                    Navigator.pop(context);
            
                  }),
          ],
        ),
      ),
    );
  }
}
