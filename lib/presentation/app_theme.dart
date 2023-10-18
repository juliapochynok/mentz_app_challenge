import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static const ColorScheme colorScheme = ColorScheme(
    brightness: Brightness.light,
    primaryContainer: Color(0xFFF9F9F9),
    primary: Color(0xFF2B602E),
    onPrimary: Color(0xFF7AAF74),
    secondary: Color(0xFFBAE3B5),
    onSecondary: Color(0xFFE5F8E4),
    tertiary: Color(0xFF3E0B5E),
    onTertiary: Color(0xFFE0D5FF),
    error: Colors.red,
    onError: Color(0xFFF9F9F9),
    background: Color(0xFFF9F9F9),
    onBackground: Colors.black,
    surface: Color(0xFFF9F9F9),
    onSurface: Colors.black,
    surfaceTint: Color(0xFFF9F9F9),
    outline: Color(0xFFF9F9F9),
    outlineVariant: Color(0xFFF9F9F9),
  );

  static final TextTheme textTheme = TextTheme(
    headlineLarge: TextStyle(
      fontFamily: 'SpaceGrotesk',
      color: colorScheme.primaryContainer,
      fontSize: 22.sp,
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal,
      height: 1,
      letterSpacing: 0,
    ),
    titleMedium: TextStyle(
      fontFamily: 'SpaceGrotesk',
      color: colorScheme.onBackground,
      fontSize: 16.sp,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.normal,
      height: 1.5,
      letterSpacing: 0,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'SpaceGrotesk',
      color: colorScheme.onBackground,
      fontSize: 16.sp,
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal,
      height: 1.5,
      letterSpacing: 0,
    ),
    bodySmall: TextStyle(
      fontFamily: 'SpaceGrotesk',
      color: colorScheme.onBackground,
      fontSize: 12.sp,
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.normal,
      height: 1.5,
      letterSpacing: 0.4.sp,
    ),
    labelMedium: TextStyle(
      fontFamily: 'SpaceGrotesk',
      color: colorScheme.onBackground,
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      height: 1.5,
      letterSpacing: 0,
    ),
    labelSmall: TextStyle(
      fontFamily: 'SpaceGrotesk',
      color: colorScheme.onBackground,
      fontSize: 12.sp,
      fontWeight: FontWeight.w500,
      fontStyle: FontStyle.normal,
      height: 1.5,
      letterSpacing: 0,
    ),
  );
}
