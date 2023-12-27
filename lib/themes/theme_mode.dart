import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/themes/palette.dart';

class ThemeClass {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    // text theme
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Palette.xColor,
      ),
      titleMedium: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.normal,
        color: Palette.xColor,
      ),
      displayLarge: TextStyle(
        fontSize: 20,
        color: Palette.xColor,
      ),
      displayMedium: TextStyle(
        fontSize: 18,
        color: Palette.xColor,
      ),
      displaySmall: TextStyle(
        fontSize: 14,
        color: Palette.grey,
      ),
    ),

    // app bar theme
    appBarTheme: const AppBarTheme(
      elevation: 2,
    ),

    // switch theme
    switchTheme: const SwitchThemeData(
      trackColor: MaterialStatePropertyAll<Color>(Palette.blue),
      trackOutlineColor: MaterialStatePropertyAll<Color>(Palette.blue),
    ),
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
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
        fontSize: 16,
      ),
      displaySmall: TextStyle(
        fontSize: 14,
        color: Palette.grey,
      ),
    ),

    // app bar theme
    appBarTheme: const AppBarTheme(
      elevation: 2,
    ),
  );
}
