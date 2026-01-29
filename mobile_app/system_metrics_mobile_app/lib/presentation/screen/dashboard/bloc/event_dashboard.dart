/* 
Created by Neloy on 29 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'bloc_dashboard.dart';

abstract class EventDashboard extends Equatable {
  const EventDashboard();

  @override
  List<Object?> get props => [];
}

class EventGetMatrics extends EventDashboard {}
