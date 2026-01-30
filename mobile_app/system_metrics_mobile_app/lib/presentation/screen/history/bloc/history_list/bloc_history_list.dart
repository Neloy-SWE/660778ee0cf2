/* 
Created by Neloy on 29 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_metrics_mobile_app/core/app_text.dart';
import 'package:system_metrics_mobile_app/data/model/model_history_list.dart';
import 'package:system_metrics_mobile_app/data/repository/repository_get_vitals.dart';

part 'event_history_list.dart';

part 'state_history_list.dart';

class BlocHistoryList extends Bloc<EventHistoryList, StateHistoryList> {
  final IRepositoryGetVitals repositoryGetVitals;

  BlocHistoryList({required this.repositoryGetVitals})
    : super(StateHistoryListLoadInitial()) {
    on<EventGetHistoryList>(_onGetHistoryList, transformer: droppable());
    on<EventHistoryListLoadMore>(
      _onGetHistoryListLoadMore,
      transformer: droppable(),
    );
  }

  int pageNumber = 1;
  int pageSize = 10;
  List<History> items = [];
  int maxCount = 0;

  Future<void> _onGetHistoryList(
    EventGetHistoryList event,
    Emitter<StateHistoryList> emit,
  ) async {
    pageNumber = 1;
    pageSize = 10;
    var (historyList, fail) = await repositoryGetVitals.getHistoryList(
      pageNumber: pageNumber,
      pageSize: pageSize,
    );

    if (fail == null) {
      items = historyList!.items!;
      maxCount = historyList.totalCount!;
      emit(StateHistoryListLoadPass());
    } else {
      emit(StateHistoryListLoadFail(message: fail));
    }
  }

  Future<void> _onGetHistoryListLoadMore(
    EventHistoryListLoadMore event,
    Emitter<StateHistoryList> emit,
  ) async {
    emit(StateHistoryListExtending());
    if (items.length < maxCount) {
      var (historyList, fail) = await repositoryGetVitals.getHistoryList(
        pageNumber: pageNumber + 1,
        pageSize: pageSize,
      );

      if (fail == null) {
        items.addAll(historyList!.items!);
        pageNumber++;
        emit(StateHistoryListLoadPass());
      } else {
        emit(StateHistoryListLoadFail(message: fail));
      }
    } else {
      emit(StateHistoryListMaxLoad(message: AppText.noMoreHistory));
    }
  }
}
