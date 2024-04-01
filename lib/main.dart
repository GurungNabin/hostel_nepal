import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hostel_nepal/features/auth/auth_controller/auth_controller.dart';
import 'package:hostel_nepal/features/auth/auth_screens/splash_screen.dart';
import 'package:hostel_nepal/constants/global_variables.dart';

import 'package:hostel_nepal/router.dart';

// nabin@gmail.com
// #Nabin123

//divya@gyan.com
//#Gyan123

//ram@gmail.com
//Ram1234#
void main() async {
  await ScreenUtil.ensureScreenSize();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    getUserData();
    getProviderData();
  }

  bool data = false;

  getUserData() async {
    data = await ref.read(authControllerProvider).getUserData();
    setState(() {});
  }

  getProviderData() {}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ScreenUtilInit(
      useInheritedMediaQuery: true,
      designSize: Size(size.width, size.height),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.poppinsTextTheme(),
          scaffoldBackgroundColor: GlobalVariables.backgroundColour,
          colorScheme:
              const ColorScheme.light(primary: GlobalVariables.mainColor),
          appBarTheme: const AppBarTheme(
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          useMaterial3: false,
        ),
        onGenerateRoute: (settings) => generateRoute(settings),
        home: SplashScreen(
          data: data,
        ),
      ),
    );
  }
}
