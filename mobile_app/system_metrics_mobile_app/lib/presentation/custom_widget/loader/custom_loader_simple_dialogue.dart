/* 
Created by Neloy on 29 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';

import '../../../core/app_color.dart';

class CustomLoaderSimpleDialogue {
  static Future<void> show({required BuildContext context}) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (builder) => Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: UnconstrainedBox(
            child: SizedBox(
              height: 40,
              width: 40,
              child: CircularProgressIndicator(color: AppColor.colorSecondary),
            ),
          ),
        ),
      ),
    );
  }
}
