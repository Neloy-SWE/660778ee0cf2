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
import 'package:system_metrics_mobile_app/data/repository/repository_post_vitals.dart';

part 'event_dashboard.dart';

part 'state_dashboard.dart';

class BlocDashboard extends Bloc<EventDashboard, StateDashboard> {
  final IRepositoryPostVitals repositoryPostVitals;

  BlocDashboard({required this.repositoryPostVitals})
    : super(StateDashboardInitialLoad()) {
    on<EventGetMetrics>(_onGetMatrics, transformer: restartable());
    on<EventSaveMetrics>(_onSaveMatrics, transformer: restartable());
  }

  static const MethodChannel _channel = MethodChannel(
    AppConstant.methodChannelName,
  );
  ModelSystemMetrics? systemMetrics;

  Future<void> _onGetMatrics(
    EventGetMetrics event,
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
        timestamp: DateTime.now().toUtc(),
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

  Future<void> _onSaveMatrics(
    EventSaveMetrics event,
    Emitter<StateDashboard> emit,
  ) async {
    emit(StateDashboardSaveMetricsLoad());

    var (pass, fail) = await repositoryPostVitals.addDeviceDetails(
      systemMetrics: systemMetrics!,
    );
    if (fail == null) {
      emit(StateDashboardSaveMetricsDone(message: pass!));
    } else {
      emit(StateDashboardFail(message: fail));
    }
  }
}
