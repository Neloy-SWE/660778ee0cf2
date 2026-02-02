/* 
Created by Neloy on 29 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:system_metrics_mobile_app/data/client/client_constant.dart';
import 'package:system_metrics_mobile_app/data/model/model_analytics.dart';

import '../api/api_call_get_vitals_analytics.dart';

abstract class IRepositoryGetVitalsAnalytics {
  Future<(List<ModelAnalytics>? analyticsData, String? fail)> getAnalytics({
    required String deviceId,
    DateTime? dateFrom,
    DateTime? dateTo,
  });
}

class RepositoryGetVitalsAnalytics extends IRepositoryGetVitalsAnalytics {
  final IApiCallGetVitalsAnalytics apiCallGetVitalsAnalytics;

  RepositoryGetVitalsAnalytics({required this.apiCallGetVitalsAnalytics});

  @override
  Future<(List<ModelAnalytics>?, String?)> getAnalytics(
      {required String deviceId, DateTime? dateFrom, DateTime? dateTo}) async {
    try {
      Map<String, dynamic> data = {
        ClientConstant.deviceId: deviceId,
        ClientConstant.fromDate: dateFrom,
        ClientConstant.toDate: dateTo,
      };

      List<ModelAnalytics> analyticsData = await apiCallGetVitalsAnalytics.getAnalyticsData(data: data);
      // if (response.statusCode == ClientConstant.statusCode200OK) {
      //   final dataList = response.data as List<dynamic>;
      //   List<ModelAnalytics> analyticsData = dataList
      //       .map((voter) =>
      //       ModelAnalytics.fromJson(voter as Map<String, dynamic>))
      //       .toList();
      //
      //   return (analyticsData, null);
      // }
      // else {
      //   return (null, ClientConstant.dataFetchedFailed);
      // }
      return (analyticsData, null);
    } on Exception {
      return (null, ClientConstant.dataFetchedFailed);
    }
  }
}
