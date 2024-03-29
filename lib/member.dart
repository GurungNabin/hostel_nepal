import 'package:flutter/material.dart';

class Member extends StatelessWidget {
  const Member({super.key});
  static const String routeName = '/member-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //new member
            InkWell(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const HostelMain(),
                //   ),
                // );
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
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const Dashboard(),
                //   ),
                // );
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
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
