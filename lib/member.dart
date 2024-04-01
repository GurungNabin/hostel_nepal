import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hostel_nepal/features/auth/auth_controller/auth_controller.dart';
import 'package:hostel_nepal/features/dashboard/dashboard_main.dart';
import 'package:hostel_nepal/features/hostel/hostel_screen/hostel_screen.dart';

class Member extends ConsumerStatefulWidget {
  const Member({super.key});

  static const String routeName = '/member-screen';

  @override
  ConsumerState<Member> createState() => _MemberState();
}

class _MemberState extends ConsumerState<Member> {
  //logout
  void logoutProfile(
    BuildContext context,
  ) {
    ref.read(authControllerProvider).logOutUser(context);
  }

  //for logout
  void _showLogoutConfirmDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              'Logout',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold),
            ),
            content: const Text(
              'Are you sure you want to logout?',
              style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.red),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                child: const Text(
                  'Cancle',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
              ),
              TextButton(
                  onPressed: () => logoutProfile(context),
                  child: const Text(
                    'Logout',
                    style: TextStyle(fontSize: 14, color: Colors.black),
                  ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
        actions: [
          TextButton(
            onPressed: () => _showLogoutConfirmDialog(context),
            child: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //new member
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HostelMain(
                        userId: '1',
                      ),
                    ),
                  );
                },
                child: const Card(
                  elevation: 5,
                  shadowColor: Colors.black87,
                  child: SizedBox(
                    height: 250,
                    width: 250,
                    child: Center(
                      child: Text(
                        'New Member',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),

              //Old member
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const DashboardMain(
                        hid: '',
                      ),
                    ),
                  );
                },
                child: const Card(
                  elevation: 5,
                  shadowColor: Colors.black87,
                  child: SizedBox(
                    height: 250,
                    width: 250,
                    child: Center(
                      child: Text(
                        'Old Member',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
