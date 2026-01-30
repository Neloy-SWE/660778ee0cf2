/* 
Created by Neloy on 29 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'bloc_analytics.dart';

abstract class EventAnalytics extends Equatable {
  const EventAnalytics();

  @override
  List<Object?> get props => [];
}

class EventGetAnalytics extends EventAnalytics {
  final String deviceId;
  final DateTime? dateFrom;
  final DateTime? dateTo;

  const EventGetAnalytics({required this.deviceId, this.dateFrom, this.dateTo});

  @override
  List<Object?> get props => [deviceId, dateFrom, dateTo];
}
