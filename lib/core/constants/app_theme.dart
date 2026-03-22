import 'package:elevate_super_fitness/core/constants/app_colors.dart';
import 'package:elevate_super_fitness/core/constants/const_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.gray,
    fontFamily: ConstKeys.cairoFont,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.mainColorL,
      onPrimary: AppColors.white,
      secondary: AppColors.black,
      onSecondary: AppColors.white,
      error: AppColors.red,
      onError: AppColors.white,
      surface: AppColors.white,
      onSurface: AppColors.mainColorL,
    ),
    textTheme: TextTheme(
      bodySmall: getTextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
      bodyMedium: getTextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
      bodyLarge: getTextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
      headlineMedium: getTextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: getTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
      labelSmall: getTextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        fontFamily: ConstKeys.balooThambi2Font,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: getTextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w800,
      ),
      iconTheme: IconThemeData(color: AppColors.black),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: false,
      fillColor: AppColors.white,
      contentPadding: EdgeInsets.only(left: 16.w, top: 4.h, bottom: 4.h),

      hintStyle: getTextStyle(
        color: AppColors.white[70],
        fontFamily: ConstKeys.balooThambi2Font,
        fontWeight: FontWeight.w400,
      ),
      labelStyle: getTextStyle(
        color: AppColors.gray,
        fontFamily: ConstKeys.balooThambi2Font,
        fontWeight: FontWeight.w400,
      ),
      floatingLabelStyle: WidgetStateTextStyle.resolveWith((states) {
        if (states.contains(WidgetState.error)) {
          return getTextStyle(color: AppColors.red);
        }
        return getTextStyle(color: AppColors.gray);
      }),
      errorStyle: getTextStyle(color: AppColors.red),
      border: getOutlineInputBorder(color: AppColors.lightGray),
      focusedBorder: getOutlineInputBorder(color: AppColors.lightGray),
      enabledBorder: getOutlineInputBorder(color: AppColors.lightGray),
      errorBorder: getOutlineInputBorder(color: AppColors.red),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(
        color: AppColors.red,
        applyTextScaling: true,
      ),
      selectedItemColor: AppColors.red,
      unselectedItemColor: AppColors.gray,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      type: BottomNavigationBarType.shifting,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.mainColorL,
        disabledBackgroundColor: AppColors.black[30],
        foregroundColor: AppColors.white,
        textStyle: getTextStyle(fontSize: 14.sp, fontWeight: FontWeight.w800),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    ),

    dialogTheme: DialogThemeData(
      titleTextStyle: getTextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
      ),
      contentTextStyle: getTextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
    ),
  );

  static InputBorder getOutlineInputBorder({required Color color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.r),
      borderSide: BorderSide(color: color, width: 1.w),
    );
  }

  static TextStyle getTextStyle({
    Color? color,
    double? fontSize,
    String? fontFamily,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      color: color ?? AppColors.black,
      fontSize: fontSize ?? 14.sp,
      fontFamily: fontFamily ?? ConstKeys.balooThambi2Font,
      fontWeight: fontWeight ?? FontWeight.w400,
    );
  }
}
