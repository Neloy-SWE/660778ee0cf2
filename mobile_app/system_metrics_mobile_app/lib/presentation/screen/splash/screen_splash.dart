/* 
Created by Neloy on 28 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:system_metrics_mobile_app/core/app_color.dart';

import '../../../core/app_size.dart';
import '../../../core/app_text.dart';
import '../../../router/app_router.dart';

class ScreenSplash extends StatefulWidget {
  const ScreenSplash({super.key});

  @override
  State<ScreenSplash> createState() => _ScreenSplashState();
}

class _ScreenSplashState extends State<ScreenSplash> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      context.replace(AppRouter.screenDashboard);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorPrimary,
      appBar: AppBar(title: Text(AppText.welcome)),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: .spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.battery_5_bar,
                    size: 100,
                    color: Colors.white,
                  ),
                  AppSize.gapH15,
                  Text(AppText.title, style: AppText.style.titleLarge),
                  AppSize.gapH10,
                  Text(
                    AppText.subtitle,
                    style: TextTheme.of(
                      context,
                    ).bodyMedium!.copyWith(color: Colors.white),
                  ),
                ],
              ),
              CircularProgressIndicator(color: AppColor.colorSecondary),
            ],
          ),
        ),
      ),
    );
  }
}
