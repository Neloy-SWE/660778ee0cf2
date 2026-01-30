/* 
Created by Neloy on 29 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'bloc_analytics.dart';

abstract class StateAnalytics extends Equatable {
  const StateAnalytics();

  @override
  List<Object?> get props => [];
}

class StateAnalyticsLoad extends StateAnalytics {}

class StateAnalyticsFail extends StateAnalytics {
  final String message;

  const StateAnalyticsFail({required this.message});

  @override
  List<Object?> get props => [message];
}

class StateAnalyticsPass extends StateAnalytics {
  final List<ModelAnalytics> analyticsData;

  const StateAnalyticsPass({required this.analyticsData});

  @override
  List<Object?> get props => [analyticsData];
}
