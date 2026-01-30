/* 
Created by Neloy on 30 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';
import 'package:system_metrics_mobile_app/data/api/api_call_get_vitals.dart';
import 'package:system_metrics_mobile_app/data/client/client_constant.dart';
import 'package:system_metrics_mobile_app/data/model/model_history_list.dart';

abstract class IRepositoryGetVitals {
  Future<(ModelHistoryList? historyList, String? fail)> getHistoryList({
    required int pageNumber,
    required int pageSize,
  });
}

class RepositoryGetVitals extends IRepositoryGetVitals {
  final IApiCallGetVitals apiCallGetVitals;

  RepositoryGetVitals({required this.apiCallGetVitals});

  @override
  Future<(ModelHistoryList?, String?)> getHistoryList({
    required int pageNumber,
    required int pageSize,
  }) async {
    try {
      Map<String, dynamic> data = {
        ClientConstant.pageNumber: pageNumber,
        ClientConstant.pageSize: pageSize,
      };

      Response response = await apiCallGetVitals.getHistory(data: data);
      if (response.statusCode == ClientConstant.statusCode200OK) {
        return (ModelHistoryList.fromRawJson(response.toString()), null);
      } else {
        return (null, ClientConstant.dataFetchedFailed);
      }
    } on Exception {
      return (null, ClientConstant.dataFetchedFailed);
    }
  }
}
