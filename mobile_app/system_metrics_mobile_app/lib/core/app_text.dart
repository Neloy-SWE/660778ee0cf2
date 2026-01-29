/* 
Created by Neloy on 28 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';

import '../router/app_router.dart';

class AppText {
  static final style = TextTheme.of(navigator.currentContext!);

  static const String title = "System Metrics";
  static const String subtitle = "Check your mobile health";
  static const String welcome = "Welcome";
  static const String dashboard = "Dashboard";
  static const String somethingWentWrong = "Something went wrong!";
  static const String pleaseTryAgain = "Please try again";
  static const String pullToRefresh = "Pull to refresh";
  static const String thermalStaus = "Thermal Status";
  static const String thermalValue = "Thermal Value";
  static const String deviceOS = "Device OS";
  static const String batteryLevel = "Battery Level";
  static const String memoryUsage = "Memory Usage";
  static const String logStatus = "Log Status";
}
