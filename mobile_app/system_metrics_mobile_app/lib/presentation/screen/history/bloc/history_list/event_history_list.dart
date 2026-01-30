/* 
Created by Neloy on 29 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'bloc_history_list.dart';

abstract class EventHistoryList extends Equatable {
  const EventHistoryList();

  @override
  List<Object?> get props => [];
}

class EventGetHistoryList extends EventHistoryList {
  final String deviceId;
  const EventGetHistoryList({required this.deviceId});

  @override
  List<Object?> get props => [deviceId];
}

class EventHistoryListLoadMore extends EventHistoryList {
  final String deviceId;
  const EventHistoryListLoadMore({required this.deviceId});

  @override
  List<Object?> get props => [deviceId];
}
