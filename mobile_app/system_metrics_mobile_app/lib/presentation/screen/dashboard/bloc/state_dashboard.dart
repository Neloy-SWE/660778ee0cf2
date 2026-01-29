/* 
Created by Neloy on 29 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'bloc_dashboard.dart';

abstract class StateDashboard extends Equatable {
  const StateDashboard();

  @override
  List<Object?> get props => [];
}

class StateDashboardInitialLoad extends StateDashboard {}

class StateDashboardDeviceDetails extends StateDashboard {
  final ModelSystemMetrics systemMetrics;

  const StateDashboardDeviceDetails({required this.systemMetrics});

  @override
  List<Object?> get props => [systemMetrics];
}

class StateDashboardFail extends StateDashboard {
  final String message;

  const StateDashboardFail({required this.message});

  @override
  List<Object?> get props => [message];
}
