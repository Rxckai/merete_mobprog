import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'constants.dart';
import 'screens/home_screen.dart';
import 'screens/newsfeed_screen.dart';

// Application entry point.
// TODO: In pubspec.yaml, replace 'surname' with your own surname
// (name: surname_mobprog). The folder name is surname_mobprog.

void main() {
  // Starts the Flutter application by passing MyApp as the root widget.
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ScreenUtilInit enables dimensions that adapt to the screen size.
    return ScreenUtilInit(
      // Design dimensions used as the reference for responsive sizing.
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        // MaterialApp configures the application theme and navigation routes.
        return MaterialApp(
          // Hides the debug banner in the top-right corner of the app.
          debugShowCheckedModeBanner: false,
          scrollBehavior: const _CleanScrollBehavior(),
          title: 'Facebook',
          theme: ThemeData(
            primaryColor: AppColors.facebookBlue,
            scaffoldBackgroundColor: AppColors.background,
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.white,
              elevation: 1,
            ),
          ),
          // Opens the home screen first when the app starts.
          initialRoute: '/home',
          // Maps route names to the widgets that should be displayed.
          routes: {
            '/home': (context) => const HomeScreen(),
            '/newsfeed': (context) => const NewsFeedScreen(),
          },
        );
      },
    );
  }
}

/// Disables Android 12+ Material 3's stretching overscroll effect so lists
/// scroll cleanly without vertically elongating cards at the edges.
class _CleanScrollBehavior extends MaterialScrollBehavior {
  const _CleanScrollBehavior();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) {
    return child;
  }
}
