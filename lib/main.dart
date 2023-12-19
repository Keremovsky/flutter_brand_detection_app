import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/router.dart';
import 'package:flutter_brand_detection_app/themes/palette.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  final router = AppRouter().router;

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Brand Detection App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Palette.mainColor,
          background: Palette.white,
        ),

        // text theme
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.normal,
          ),
          displayLarge: TextStyle(
            fontSize: 20,
          ),
          displayMedium: TextStyle(
            fontSize: 18,
          ),
          displaySmall: TextStyle(
            fontSize: 14,
            color: Palette.grey,
          ),
        ),

        // app bar theme
        appBarTheme: const AppBarTheme(
          backgroundColor: Palette.mainColor,
          scrolledUnderElevation: 0,
          elevation: 0,
        ),

        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
