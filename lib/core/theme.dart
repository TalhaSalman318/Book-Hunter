import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppColors {
  static const Color mainColor = Color(0xFFB1732E);
  static const Color secondaryColor = Color(0xFFF6AB27);
  static const Color blackColor = Color(0xFF000000);
  static const Color highlightColor = Color(0xFFFFD5A6);
  static const Color fontGreyColor = Color(0xFF999797);
  static const Color navBarGray = Color(0xFF919191);
  static const Color searchGrey = Color(0xFFF2F2F2);
  static const Color whiteColor = Color(0xFFFFFFFF);
}

class AppTextStyles {
  static TextStyle heading1 = TextStyle(
    fontSize: 22.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.blackColor,
  );

  static TextStyle heading2 = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.blackColor,
  );

  static TextStyle bodyText = TextStyle(
    fontSize: 14,
    color: AppColors.blackColor,
  );

  static TextStyle caption = TextStyle(
    fontSize: 12,
    color: AppColors.fontGreyColor,
  );
}

ThemeData appTheme = ThemeData(
  // primaryColor: AppColors.primaryColor,
  // scaffoldBackgroundColor: AppColors.backgroundColor,
  appBarTheme: const AppBarTheme(
    // backgroundColor: AppColors.primaryColor,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
  textTheme: TextTheme(
    titleLarge: AppTextStyles.heading1,
    bodyMedium: AppTextStyles.bodyText,
    bodySmall: AppTextStyles.caption,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      // backgroundColor: AppColors.primaryColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),
  ),
);
