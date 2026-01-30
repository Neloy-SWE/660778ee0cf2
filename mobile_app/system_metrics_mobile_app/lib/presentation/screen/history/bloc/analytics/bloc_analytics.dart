/* 
Created by Neloy on 29 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_metrics_mobile_app/data/model/model_analytics.dart';
import 'package:system_metrics_mobile_app/data/repository/repository_get_vitals_analytics.dart';

part 'event_analytics.dart';

part 'state_analytics.dart';

class BlocAnalytics extends Bloc<EventAnalytics, StateAnalytics> {
  final IRepositoryGetVitalsAnalytics repositoryGetVitalsAnalytics;

  BlocAnalytics({required this.repositoryGetVitalsAnalytics})
    : super(StateAnalyticsLoad()) {
    on<EventGetAnalytics>(_onGetAnalytics, transformer: restartable());
  }

  Future<void> _onGetAnalytics(
    EventGetAnalytics event,
    Emitter<StateAnalytics> emit,
  ) async {
    emit(StateAnalyticsLoad());
    var (analyticsData, fail) = await repositoryGetVitalsAnalytics.getAnalytics(
      deviceId: event.deviceId,
      dateFrom: event.dateFrom,
      dateTo: event.dateTo,
    );

    if (fail == null) {
      emit(StateAnalyticsPass(analyticsData: analyticsData!));
    } else {
      emit(StateAnalyticsFail(message: fail));
    }
  }
}
