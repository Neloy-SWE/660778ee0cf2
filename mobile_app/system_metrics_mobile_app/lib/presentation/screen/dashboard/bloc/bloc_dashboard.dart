/* 
Created by Neloy on 29 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_metrics_mobile_app/core/app_constant.dart';
import 'package:system_metrics_mobile_app/core/app_text.dart';
import 'package:system_metrics_mobile_app/data/model/model_system_metrics.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

part 'event_dashboard.dart';

part 'state_dashboard.dart';

class BlocDashboard extends Bloc<EventDashboard, StateDashboard> {
  BlocDashboard() : super(StateDashboardInitialLoad()) {
    on<EventGetMatrics>(_onGetMatrics, transformer: restartable());
  }

  static const MethodChannel _channel = MethodChannel(
    AppConstant.methodChannelName,
  );
  ModelSystemMetrics? systemMetrics;

  Future<void> _onGetMatrics(
    EventGetMatrics event,
    Emitter<StateDashboard> emit,
  ) async {
    emit(StateDashboardInitialLoad());

    try {
      final Map<dynamic, dynamic> thermal = await _channel.invokeMethod(
        AppConstant.metricsThermal,
      );
      final Map<dynamic, dynamic> battery = await _channel.invokeMethod(
        AppConstant.metricsBattery,
      );
      final Map<dynamic, dynamic> memory = await _channel.invokeMethod(
        AppConstant.metricsMemory,
      );
      String? deviceId = await _channel.invokeMethod<String>(
        AppConstant.getAndroidId,
      );

      systemMetrics = ModelSystemMetrics(
        thermalStatus: thermal[AppConstant.thermalStatus],
        thermalValue: thermal[AppConstant.thermalLevel],
        batteryLevel: battery[AppConstant.batteryLevel],
        memoryUsage: (memory[AppConstant.memoryUsage]).toInt(),
        deviceId: deviceId,
        timestamp: DateTime.now(),
        deviceOs: Platform.isAndroid ? "Android" : "iOS",
      );
      emit(StateDashboardDeviceDetails(systemMetrics: systemMetrics!));
    } on Exception {
      emit(
        StateDashboardFail(
          message: "${AppText.somethingWentWrong} ${AppText.pullToRefresh}",
        ),
      );
    }
  }
}
