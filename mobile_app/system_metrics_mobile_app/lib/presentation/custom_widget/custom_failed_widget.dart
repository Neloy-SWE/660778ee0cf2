/* 
Created by Neloy on 29 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:system_metrics_mobile_app/core/app_color.dart';
import 'package:system_metrics_mobile_app/core/app_text.dart';

class CustomFailedWidget extends StatelessWidget {
  final String message;
  const CustomFailedWidget({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: .center,
        mainAxisAlignment: .center,
        children: [
          Icon(
            Icons.battery_alert,
            size: 50,
            color: AppColor.colorPrimaryShadow,
          ),
          Text(
            message,
            style: AppText.style.bodySmall!.copyWith(
              color: AppColor.colorError,
            ),
          ),
        ],
      ),
    );
  }
}
