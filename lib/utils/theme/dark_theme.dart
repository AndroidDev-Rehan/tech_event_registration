import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
  iconTheme: const IconThemeData(color: Colors.white),
  appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black87,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white)),
  primaryColor:const Color(0xFFFA2D48),
  scaffoldBackgroundColor: Colors.black,
  backgroundColor: Colors.black,
  brightness: Brightness.light,
  hintColor: const Color(0xFF9E9E9E),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.black,
  ),
  pageTransitionsTheme: _transitionsTheme,
  primaryTextTheme: Typography(platform: TargetPlatform.iOS).white,
  textTheme: Typography(platform: TargetPlatform.iOS).white,
);

PageTransitionsTheme _transitionsTheme =  const PageTransitionsTheme(builders: {
  TargetPlatform.android: ZoomPageTransitionsBuilder(),
  TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
  TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
});