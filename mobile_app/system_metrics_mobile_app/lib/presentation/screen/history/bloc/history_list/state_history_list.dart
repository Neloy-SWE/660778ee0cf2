/* 
Created by Neloy on 30 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

part of 'bloc_history_list.dart';

abstract class StateHistoryList extends Equatable {
  const StateHistoryList();

  @override
  List<Object?> get props => [];
}

class StateHistoryListLoadInitial extends StateHistoryList {}
class StateHistoryListLoadPass extends StateHistoryList {}
class StateHistoryListExtending extends StateHistoryList {}
class StateHistoryListLoadFail extends StateHistoryList {
  final String message;

  const StateHistoryListLoadFail({required this.message});
}

class StateHistoryListMaxLoad extends StateHistoryList {
  final String message;

  const StateHistoryListMaxLoad({required this.message});
}