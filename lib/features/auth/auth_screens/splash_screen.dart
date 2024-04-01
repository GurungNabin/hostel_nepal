import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hostel_nepal/features/auth/auth_screens/login_screen.dart';
import 'package:hostel_nepal/member.dart';

class SplashScreen extends StatefulWidget {
  final bool data;

  const SplashScreen({super.key, required this.data});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  void navigate(String routeName) {
    Navigator.pushNamed(context, routeName);
  }

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    Timer(const Duration(seconds: 4), () {
      // Adjusted timer duration to match animation duration
      navigate(widget.data ? Member.routeName : LoginScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image.asset(
                'assets/room.jpg',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
