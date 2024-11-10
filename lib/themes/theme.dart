// lib/theme.dart
import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: MaterialColor(
        Color.fromRGBO(246, 4, 4, 1).value, ThemeColors.primarySwatch),
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: const Color.fromRGBO(246, 4, 4, 1),
      elevation: 5,
      toolbarHeight: 70,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
      ),
      displayMedium: TextStyle(
        color: Colors.white,
        fontSize: 36.0,
        fontStyle: FontStyle.italic,
      ),
      displaySmall: TextStyle(
        color: Colors.white,
        fontSize: 14.0,
        fontFamily: 'Hind',
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: MaterialColor(
        Color.fromRGBO(246, 4, 4, 1).value, ThemeColors.primarySwatch),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: const Color.fromRGBO(246, 4, 4, 1),
      elevation: 5,
      toolbarHeight: 70,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
      ),
      displayMedium: TextStyle(
        color: Colors.white,
        fontSize: 36.0,
        fontStyle: FontStyle.italic,
      ),
      displaySmall: TextStyle(
        color: Colors.white,
        fontSize: 14.0,
        fontFamily: 'Hind',
      ),
    ),
  );
}

class ThemeColors {
  static const Color primary1 = Color.fromRGBO(246, 4, 4, 1);
  static const Color primary2 = Color.fromARGB(255, 192, 0, 0);
  static const Color primary3 = Color.fromARGB(255, 255, 255, 255);
  static const Color primary4 = Color.fromARGB(255, 0, 0, 0);

  // The Yellows
  static const Color oldYellow = Color.fromRGBO(255, 183, 0, 1);
  static const Color yellow100 = Color.fromRGBO(224, 231, 0, 1);
  static const Color yellow90 = Color.fromRGBO(210, 218, 0, 1);

  static const Color lime100 = Color.fromRGBO(191, 255, 0, 1);
  static const Color lime90 = Color.fromRGBO(178, 232, 14, 1);
  static const Color lime80 = Color.fromRGBO(163, 213, 14, 1);

  // The Blues
  static const Color royalBlue = Color.fromRGBO(34, 36, 123, 1);
  static const Color blue100 = Color.fromRGBO(8, 42, 176, 1);
  static const Color blue90 = Color.fromRGBO(10, 49, 205, 1);
  static const Color blue80 = Color.fromRGBO(22, 64, 233, 1);
  static const Color blue70 = Color.fromRGBO(46, 86, 249, 1);
  static const Color blue60 = Color.fromRGBO(74, 110, 255, 1);
  static const Color babyBlue = Color.fromRGBO(103, 164, 255, 1);

  static const Color mainRed = Color.fromRGBO(227, 0, 23, 1);
  static const Color red3 = Color.fromRGBO(246, 4, 4, 1);
  static const Color red4 = Color.fromRGBO(255, 213, 0, 1);

  static const Color purple110 = Color.fromRGBO(184, 113, 255, 1);
  static const Color purple100 = Color.fromRGBO(128, 0, 255, 1);
  static const Color purple90 = Color.fromRGBO(125, 19, 231, 1);
  static const Color purple80 = Color.fromRGBO(102, 0, 204, 1);
  static const Color purple70 = Color.fromRGBO(77, 0, 155, 1);
  static const Color purple60 = Color.fromRGBO(34, 0, 120, 1);
  static const Color purple50 = Color.fromRGBO(48, 0, 96, 1);

  // The Reds
  static const Color orange100 = Color.fromRGBO(255, 51, 0, 1);
  static const Color orange90 = Color.fromRGBO(252, 72, 23, 1);
  static const Color orange80 = Color.fromRGBO(255, 90, 44, 1);
  static const Color orange70 = Color.fromRGBO(255, 102, 60, 1);

  static const Color pink110 = Color.fromRGBO(255, 109, 206, 1);
  static const Color pink100 = Color.fromRGBO(237, 0, 158, 1);
  static const Color pink90 = Color.fromRGBO(240, 42, 174, 1);

  // The Greens
  static const Color green100 = Color.fromRGBO(51, 206, 34, 1);
  static const Color moneyGreen = Color.fromRGBO(0, 207, 76, 1);
  static const Color turqoise100 = Color.fromRGBO(92, 226, 202, 1);
  static const Color turqoise90 = Color.fromRGBO(83, 203, 181, 1);
  static const Color turqoise80 = Color.fromRGBO(14, 211, 169, 1);

  // The Blacks
  static const Color black100 = Color.fromRGBO(15, 15, 15, 1);
  static const Color black90 = Color.fromRGBO(41, 41, 41, 1);
  static const Color black80 = Color.fromRGBO(62, 62, 62, 1);
  static const Color black70 = Color.fromRGBO(89, 89, 89, 1);
  static const Color black60 = Color.fromRGBO(107, 107, 107, 1);

  // The Greys
  static const Color greyMain = Color.fromRGBO(234, 234, 238, 1);
  static const Color grey100 = Color.fromRGBO(86, 88, 90, 1);
  static const Color grey90 = Color.fromRGBO(150, 153, 156, 1);
  static const Color grey80 = Color.fromRGBO(200, 203, 205, 1);

  static const Color info6 = Color.fromRGBO(69, 131, 219, 1);
  static const Color info7 = Color.fromRGBO(47, 98, 183, 1);
  static const Color info8 = Color.fromRGBO(30, 68, 147, 1);
  static const Color black200 = Color.fromRGBO(234, 237, 238, 1);
  static const Color black300 = Color.fromRGBO(200, 203, 205, 1);
  static const Color black400 = Color.fromRGBO(150, 153, 156, 1);
  static const Color black500 = Color.fromRGBO(86, 88, 90, 1);
  static const Color black800 = Color.fromRGBO(27, 36, 52, 1);
  static const Color grey4 = Color.fromRGBO(169, 186, 193, 1);
  static const Color grey1 = Color.fromRGBO(241, 248, 249, 1);
  static const Color grey5 = Color.fromRGBO(127, 143, 152, 1);
  static const Color grey3 = Color.fromRGBO(201, 218, 224, 1);
  static const Color grey2 = Color.fromRGBO(228, 241, 244, 1);
  static const Color danger5 = Color.fromRGBO(251, 48, 48, 1);
  static const Color warning5 = Color.fromRGBO(255, 171, 54, 1);
  static const Color success7 = Color.fromRGBO(52, 164, 21, 1);
  static const Color success6 = Color.fromRGBO(77, 196, 31, 1);
  static const Color success4 = Color.fromRGBO(0, 207, 76, 1);
  static const Color success1 = Color.fromRGBO(237, 253, 212, 1);
  static const Color white = Colors.white;

  static const Map<int, Color> primarySwatch = {
    50: Color.fromRGBO(246, 4, 4, .1),
    100: Color.fromRGBO(246, 4, 4, .2),
    200: Color.fromRGBO(246, 4, 4, .3),
    300: Color.fromRGBO(246, 4, 4, .4),
    400: Color.fromRGBO(246, 4, 4, .5),
    500: Color.fromRGBO(246, 4, 4, .6),
    600: Color.fromRGBO(246, 4, 4, .7),
    700: Color.fromRGBO(246, 4, 4, .8),
    800: Color.fromRGBO(246, 4, 4, .9),
    900: Color.fromRGBO(246, 4, 4, 1),
  };
}
