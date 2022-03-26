import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: const Color(0xFFFA2D48),
  scaffoldBackgroundColor: Colors.black,
  brightness: Brightness.light,
  pageTransitionsTheme: _transitionsTheme,
  primaryTextTheme: Typography(platform: TargetPlatform.iOS).white,
  textTheme: Typography(platform: TargetPlatform.iOS).white,
);

PageTransitionsTheme _transitionsTheme =  const PageTransitionsTheme(builders: {
  TargetPlatform.android: ZoomPageTransitionsBuilder(),
  TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
  TargetPlatform.fuchsia: ZoomPageTransitionsBuilder(),
});