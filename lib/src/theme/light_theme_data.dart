import 'package:flutter/material.dart';
import 'package:your_app_test/src/theme/palette.dart';
import 'package:your_app_test/src/style/font_style.constant.dart';
import 'package:your_app_test/src/theme/lighten_darken_color.dart';
import 'package:your_app_test/src/theme/theme.dart';

ThemeData lightThemeData(MyTheme theme) {
  return ThemeData(
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Palette.white,
      border: UnderlineInputBorder(
        borderSide: BorderSide(color: Palette.black),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Palette.black),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Palette.black),
      ),
      errorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Palette.black),
      ),
      focusedErrorBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Palette.black),
      ),
    ),
    drawerTheme: const DrawerThemeData(
        backgroundColor: Palette.bgColorLight, elevation: 0),
    useMaterial3: true,
    colorSchemeSeed: theme.getColor(),
    scaffoldBackgroundColor: Palette.white,
    brightness: Brightness.light,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStateProperty.resolveWith((states) {
          return FontStylesConstants.gilroy(
              fontSize: 16, color: darken(theme.getColor(), 0.35));
        }),
        shape: WidgetStateProperty.resolveWith((states) {
          return RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(90),
          );
        }),
        fixedSize: const WidgetStatePropertyAll(Size.fromHeight(60)),
        maximumSize: const WidgetStatePropertyAll(Size.fromHeight(60)),
        minimumSize: const WidgetStatePropertyAll(Size.fromHeight(60)),
        backgroundColor: const WidgetStatePropertyAll(
          Colors.transparent,
        ),
        foregroundColor: const WidgetStatePropertyAll(
          Palette.white,
        ),
      ),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: theme.getColor(),
      textTheme: ButtonTextTheme.accent,
      height: 70,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10,
        ),
      ),
    ),
    textTheme: TextTheme(
      titleSmall: FontStylesConstants.gilroy(fontSize: 8, color: Palette.black),
      titleMedium:
          FontStylesConstants.gilroy(fontSize: 10, color: Palette.black),
      bodySmall: FontStylesConstants.gilroy(fontSize: 14, color: Palette.black),
      bodyMedium:
          FontStylesConstants.gilroy(fontSize: 16, color: Palette.black),
      bodyLarge: FontStylesConstants.gilroy(fontSize: 18, color: Palette.black),
      labelSmall:
          FontStylesConstants.gilroy(fontSize: 12, color: Palette.black),
      titleLarge:
          FontStylesConstants.gilroy(fontSize: 20, color: Palette.black),
      labelMedium:
          FontStylesConstants.gilroy(fontSize: 22, color: Palette.black),
      labelLarge:
          FontStylesConstants.gilroy(fontSize: 24, color: Palette.black),
      headlineSmall:
          FontStylesConstants.gilroy(fontSize: 26, color: Palette.black),
      headlineMedium:
          FontStylesConstants.gilroy(fontSize: 28, color: Palette.black),
      headlineLarge:
          FontStylesConstants.gilroy(fontSize: 30, color: Palette.black),
      displaySmall:
          FontStylesConstants.gilroy(fontSize: 32, color: Palette.black),
      displayMedium:
          FontStylesConstants.gilroy(fontSize: 34, color: Palette.black),
      displayLarge:
          FontStylesConstants.gilroy(fontSize: 36, color: Palette.black),
    ),
  );
}
