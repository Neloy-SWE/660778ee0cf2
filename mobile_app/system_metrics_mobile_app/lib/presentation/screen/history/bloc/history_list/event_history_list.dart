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

class EventGetHistoryList extends EventHistoryList {}

class EventHistoryListLoadMore extends EventHistoryList {}
