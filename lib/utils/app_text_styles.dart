import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle SubTitleStyle(
    {bool responsible = false, double? height, Color? color}) {
  return TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      fontFamily: 'Noto Sans KR',
      color: color,
      height: height);
}


TextStyle displayLargeStyle({Color? color}) {
  return TextStyle(
    fontFamily: 'NotoSansKR',
    fontWeight: FontWeight.w400,
    fontSize: 60,
    height: 72 / 60,
    letterSpacing: -0.25,
    color: color
  );
}

TextStyle displayMediumStyle({Color? color}) {
  return TextStyle(
   fontFamily: 'NotoSansKR',
    fontWeight: FontWeight.w400,
    fontSize: 50,
    height: 60 / 50,
    letterSpacing: -0.25,
    color: color
    );
}

TextStyle displaySmallStyle({Color? color}) {
  return TextStyle(
   fontFamily: 'NotoSansKR',
    fontWeight: FontWeight.w700,
    fontSize: 36,
    height: 44 / 36,
    letterSpacing: -0.25,
    color: color
    );
}

TextStyle headlineLargeStyle({Color? color}) {
  return TextStyle(
     fontWeight: FontWeight.w700,
    fontSize: 32,
    height: 40 / 32,
    letterSpacing: 0,
    color: color
    );
}

TextStyle headlineMediumStyle({Color? color}) {
  return TextStyle(
    fontFamily: 'NotoSansKR',
    fontWeight: FontWeight.w400,
    fontSize: 24,
    height: 34 / 24,
    letterSpacing: 0,
    color: color
    );
}

TextStyle headlineSmallStyle({Color? color}) {
  return TextStyle(
    fontFamily: 'NotoSansKR',
    fontWeight: FontWeight.w400,
    fontSize: 22,
    height: 30 / 22,
    letterSpacing: 0,
    color: color
    );
}

TextStyle titleLargeStyle({Color? color}) {
  return TextStyle(
    fontFamily: 'NotoSansKR',
    fontWeight: FontWeight.w700,
    fontSize: 20,
    height: 28 / 20,
    letterSpacing: 0,
    color: color
    );
}

TextStyle titleMediumStyle({Color? color}) {
  return TextStyle(
    fontFamily: 'NotoSansKR',
    fontWeight: FontWeight.w700,
    fontSize: 16,
    height: 22 / 16,
    letterSpacing: 0,
    color: color
    );
}

TextStyle titleSmallStyle({Color? color}) {
  return TextStyle(
    fontFamily: 'NotoSansKR',
    fontWeight: FontWeight.w700,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0.1,
    color: color
    );
}

TextStyle labelLargeStyle({Color? color}) {
  return TextStyle(
    fontFamily: 'NotoSansKR',
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 16 / 14,
    letterSpacing: 0,
    color: color
    );
}

TextStyle labelMediumStyle({Color? color}) {
  return TextStyle(
    fontFamily: 'NotoSansKR',
    fontWeight: FontWeight.w500,
    fontSize: 12,
    height: 14 / 12,
    letterSpacing: 0,
    color: color
    );
}

TextStyle labelSmallStyle({Color? color}) {
  return TextStyle(
    fontFamily: 'NotoSansKR',
    fontWeight: FontWeight.w500,
    fontSize: 10,
    height: 12 / 10,
    letterSpacing: 0,
    color: color
    );
}

TextStyle bodyLargeStyle({Color? color}) {
  return TextStyle(
    fontFamily: 'NotoSansKR',
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 26 / 16,
    letterSpacing: 0.5,
    color: color
    );
}

TextStyle bodyMediumStyle({Color? color}) {
  return TextStyle(
    fontFamily: 'NotoSansKR',
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 22 / 14,
    letterSpacing: 0.25,
    color: color
    );
}


TextStyle bodySmallStyle({Color? color}) {
  return TextStyle(
    fontFamily: 'NotoSansKR',
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 20 / 12,
    letterSpacing: 0.4,
    color: color
    );
}



