/* 
Created by Neloy on 29 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:system_metrics_mobile_app/data/api/api_call_post_vitals.dart';
import 'package:system_metrics_mobile_app/data/client/client_constant.dart';
import 'package:system_metrics_mobile_app/data/model/model_system_metrics.dart';

abstract class IRepositoryPostVitals {
  Future<(String? pass, String? fail)> addDeviceDetails({
    required ModelSystemMetrics systemMetrics,
  });
}

class RepositoryPostVitals extends IRepositoryPostVitals {
  final IApiCallPostVitals apiCallPostVitals;

  RepositoryPostVitals({required this.apiCallPostVitals});

  @override
  Future<(String? pass, String? fail)> addDeviceDetails({
    required ModelSystemMetrics systemMetrics,
  }) async {
    try {
      Map<String, dynamic> data = systemMetrics.toJson();
      String result = await apiCallPostVitals.addDeviceDetails(data: data);
      if (result == ClientConstant.created) {
        return (ClientConstant.dataSavedSuccessfully, null);
      } else {
        return (null, ClientConstant.dataSavedFailed);
      }
    } on Exception {
      return (null, ClientConstant.networkIssue);
    }
  }
}
