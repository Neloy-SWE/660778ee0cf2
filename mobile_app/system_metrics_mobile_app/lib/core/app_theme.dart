/* 
Created by Neloy on 28 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:system_metrics_mobile_app/core/app_asset.dart';

import 'app_color.dart';

class AppTheme {
  static final get = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      backgroundColor: AppColor.colorPrimary,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: AppColor.colorPrimary,
        statusBarIconBrightness: Brightness.light,
      ),
      titleTextStyle: TextStyle(
        fontFamily: AppAsset.fontBold,
        color: Colors.white,
        fontSize: 22,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),

    textSelectionTheme: .new(
      cursorColor: AppColor.colorPrimary,
      selectionColor: AppColor.colorPrimaryShadow,
      selectionHandleColor: AppColor.colorPrimary,
    ),
    snackBarTheme: .new(
      // backgroundColor: AppColor.colorPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      contentTextStyle: TextStyle(
        fontFamily: AppAsset.fontRegular,
        fontSize: 10,
        color: Colors.white,
      ),

    ),

    textTheme: TextTheme(
      // for title related text
      titleLarge: TextStyle(
        fontFamily: AppAsset.fontBold,
        color: Colors.white,
        fontSize: 25,
      ),

      bodySmall: TextStyle(
        fontFamily: AppAsset.fontBold,
        color: Colors.white,
        fontSize: 14,
      ),

      bodyMedium: TextStyle(
        fontFamily: AppAsset.fontRegular,
        color: Colors.black,
        fontSize: 14,
      ),

      bodyLarge: TextStyle(
        fontFamily: AppAsset.fontBold,
        color: Colors.black,
        fontSize: 18,
      ),


    ),
  );
}
