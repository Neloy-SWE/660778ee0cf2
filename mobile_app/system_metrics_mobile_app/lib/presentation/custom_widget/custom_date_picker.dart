/* 
Created by Neloy on 29 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:system_metrics_mobile_app/core/app_color.dart';
import 'package:system_metrics_mobile_app/core/app_size.dart';
import 'package:system_metrics_mobile_app/core/app_text.dart';

class CustomDatePicker extends StatelessWidget {
  final void Function() onTapCalender;
  final void Function() onTapClearField;
  final String dateData;
  final bool isDataClear;
  final String title;

  const CustomDatePicker({
    super.key,
    required this.onTapCalender,
    required this.onTapClearField,
    required this.dateData,
    required this.isDataClear,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          title,
          style: AppText.style.bodySmall!.copyWith(color: Colors.black),
        ),
        AppSize.gapH05,
        GestureDetector(
          onTap: onTapCalender,
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColor.colorPrimary, width: 1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(dateData, style: AppText.style.bodyMedium),
                InkWell(
                  onTap:isDataClear ? onTapClearField : (){},
                  child: Icon(
                    isDataClear ? Icons.close : Icons.event,
                    color: AppColor.colorSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
