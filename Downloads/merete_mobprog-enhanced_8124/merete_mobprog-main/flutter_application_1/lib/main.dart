import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_application_1/constant.dart';
import 'package:flutter_application_1/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: kAppName, // Enhancement 4
        // Enhancement 5: the whole theme is built from the palette.
        theme: ThemeData(
          fontFamily: 'Frutiger',
          colorScheme: ColorScheme.fromSeed(
            seedColor: fbPrimary,
            primary: fbPrimary,
            secondary: fbSecondary,
          ),
          scaffoldBackgroundColor: fbBackground,
          cardTheme: const CardThemeData(
            color: Colors.white,
            surfaceTintColor: Colors.transparent,
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
