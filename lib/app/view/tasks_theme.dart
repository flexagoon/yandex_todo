import 'package:flutter/material.dart';
import 'package:yandex_todo/app/view/custom_colors.dart';
import 'package:yandex_todo/app/view/custom_text_colors.dart';

@immutable
final class TasksTheme {
  static final light = ThemeData(
    extensions: const [
      CustomColors(
        red: Color(0xFFFF3830),
        green: Color(0xFF34C759),
        blue: Color(0xFF007AFF),
        gray: Color(0xFF8E8E93),
        lightGray: Color(0xFFD1D1D6),
      ),
      CustomTextColors(
        primary: Color(0xFF000000),
        secondary: Color(0x99000000),
        tertiary: Color(0x4D000000),
        disable: Color(0x26000000),
      ),
    ],
    colorScheme: const ColorScheme.light(),
    scaffoldBackgroundColor: const Color(0xFFF7F6F2),
    textTheme: _textTheme.apply(
      displayColor: Colors.black,
      bodyColor: Colors.black,
    ),
    appBarTheme: const AppBarTheme(
      color: Color(0xFFF7F6F2),
      elevation: 0,
      scrolledUnderElevation: 4,
    ),
  );

  static final dark = ThemeData(
    extensions: const [
      CustomColors(
        red: Color(0xFFFF453A),
        green: Color(0xFF32D748),
        blue: Color(0xFF0A84FF),
        gray: Color(0xFF8E8E93),
        lightGray: Color(0xFF48484A),
      ),
      CustomTextColors(
        primary: Color(0xFFFFFFFF),
        secondary: Color(0x99FFFFFF),
        tertiary: Color(0x66FFFFFF),
        disable: Color(0x26FFFFFF),
      ),
    ],
    colorScheme: const ColorScheme.dark(
      surface: Color(0xFF252528),
    ),
    scaffoldBackgroundColor: const Color(0xFF161618),
    textTheme: _textTheme.apply(
      displayColor: Colors.white,
      bodyColor: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      color: Color(0xFF161618),
      elevation: 0,
      scrolledUnderElevation: 4,
    ),
  );

  static final _textTheme = const TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w500,
    ),
    headlineSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
    ),
  ).apply(
    fontFamily: 'Roboto',
  );
}
