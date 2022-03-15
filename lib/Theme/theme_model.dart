import 'package:flutter/material.dart';

import 'config.dart';

class ThemeModel {
  final lightMode = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Config().appColor,
    primaryColorDark: Config().appDarkColor,
    iconTheme: IconThemeData(color: Colors.orange),
    fontFamily: 'Manrope',
    scaffoldBackgroundColor: Config().appColor,
    brightness: Brightness.light,
    primaryColorLight: Colors.white,
    secondaryHeaderColor: Colors.grey[600],
    shadowColor: Colors.grey[200],
    backgroundColor: Config().appColor,
    appBarTheme: AppBarTheme(
      color: Config().appDarkColor,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Colors.grey[900],
      ),
      actionsIconTheme: IconThemeData(color: Colors.white),
    ),
    textTheme: TextTheme(
      subtitle1: TextStyle(
          fontWeight: FontWeight.w500, fontSize: 16, color: Colors.grey[900]),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Config().appDarkColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white70,
    ),
  );

  final darkMode = ThemeData(
      primarySwatch: Colors.deepPurple,
      primaryColor: Config().appColor,
      iconTheme: IconThemeData(color: Colors.white),
      fontFamily: 'Manrope',
      scaffoldBackgroundColor: Color(0xff303030),
      brightness: Brightness.dark,
      primaryColorDark: Colors.grey[300],
      primaryColorLight: Colors.grey[800],
      secondaryHeaderColor: Colors.grey[400],
      shadowColor: Color(0xff282828),
      backgroundColor: Colors.grey[900],
      appBarTheme: AppBarTheme(
        color: Colors.grey[900],
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        actionsIconTheme: IconThemeData(color: Colors.white),
      ),
      textTheme: TextTheme(
        subtitle1: TextStyle(
            fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.grey[900],
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[500],
      ));
}
