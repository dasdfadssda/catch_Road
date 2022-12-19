import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static TextTheme regularTextTheme = TextTheme(
    displayLarge: displayLargeStyle(),
    displayMedium: displayMediumStyle(),
    displaySmall: displaySmallStyle(),
    headlineLarge: headlineLargeStyle(),
    headlineMedium: headlineMediumStyle(),
    headlineSmall: headlineSmallStyle(),
    titleLarge: titleLargeStyle(),
    titleMedium: titleMediumStyle(),
    titleSmall: titleSmallStyle(),
    labelLarge: labelLargeStyle(),
    labelMedium: labelMediumStyle(),
    labelSmall: labelSmallStyle(),
    bodyLarge: bodyLargeStyle(),
    bodyMedium: bodyMediumStyle(),
    bodySmall: bodySmallStyle(),
  );

  static ColorScheme regularColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: primary,
    onPrimary: onPrimaryColor,
    primaryContainer: primaryContainerColor,
    onPrimaryContainer: onPrimaryContainerColor,
    secondary: secondary,
    error: error,
    onError: onErrorColor,
    errorContainer: errorContainerColor,
    onErrorContainer: onErrorContainerColor,
    background: backgroundColor,
    onBackground: onBackgroundColor,
    surface: surfaceColor,
    onSurface: onSurfaceColor,
    onSecondary: onSecondaryColor,
  );
}
