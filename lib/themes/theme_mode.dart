import 'package:flutter/material.dart';
import 'package:flutter_brand_detection_app/themes/palette.dart';

class ThemeClass {
  static ThemeData lightTheme = ThemeData(
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

    // switch theme
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.all(Palette.mainColor),
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
        fontSize: 18,
      ),
      displaySmall: TextStyle(
        fontSize: 14,
        color: Palette.grey,
      ),
    ),

    // app bar theme
    appBarTheme: const AppBarTheme(
      backgroundColor: Palette.darkMainColor,
      scrolledUnderElevation: 0,
      elevation: 0,
    ),

    // switch theme
    switchTheme: SwitchThemeData(
      trackOutlineWidth: MaterialStateProperty.all(0),
    ),
  );
}
