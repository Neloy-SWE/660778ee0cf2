/* 
Created by Neloy on 29 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';

import '../../core/app_color.dart';
import '../../core/app_text.dart';

class CustomButton extends StatelessWidget {
  final void Function()? onPressed;
  final String buttonText;
  final Color colorButton;
  final Color colorBorder;
  final Color textColor;
  final double height;

  const CustomButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.colorButton = AppColor.colorPrimary,
    this.colorBorder = AppColor.colorPrimary,
    this.textColor = Colors.white,
    this.height = 50,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: height,
      elevation: 0,
      onPressed: onPressed,
      color: colorButton,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: colorBorder, width: 1),
      ),
      child: Text(
        buttonText,
        style: AppText.style.bodySmall!.copyWith(color: textColor),
      ),
    );
  }
}
