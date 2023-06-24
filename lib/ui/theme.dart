import 'package:flutter/material.dart';
import 'package:slightly_notie/ui/colors.dart';

final _textTheme = const TextTheme(
  titleMedium: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 16),
  bodySmall: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 14),
  labelMedium: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 16),
  bodyLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 16),
  bodyMedium: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 15),
).apply(
  fontFamily: 'Satoshi',
);

final ThemeData appTheme = ThemeData.light().copyWith(
  primaryColor: SlightlyColors.backgroundBlack,
  scaffoldBackgroundColor: Colors.white,
  textTheme: _textTheme,
);
