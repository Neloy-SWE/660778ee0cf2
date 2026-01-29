/* 
Created by Neloy on 29 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:system_metrics_mobile_app/core/app_color.dart';

class CustomSnackBar {
  static void show({
    required BuildContext context,
    required String contentText,
    bool isError = false,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(contentText),
        behavior: SnackBarBehavior.floating,
        backgroundColor: !isError ? AppColor.colorPrimary : AppColor.colorError,
        margin: .only(left: 30, right: 30, bottom: 50),
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      ),
    );
  }
}
