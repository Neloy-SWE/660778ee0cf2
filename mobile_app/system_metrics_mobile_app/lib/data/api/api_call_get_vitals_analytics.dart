/* 
Created by Neloy on 29 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';

import '../client/client.dart';
import '../model/model_analytics.dart';
import 'api_path.dart';

abstract class IApiCallGetVitalsAnalytics {
  Future<List<ModelAnalytics>> getAnalyticsData({required Map<String, dynamic> data});
}

class ApiCallGetVitalsAnalytics extends IApiCallGetVitalsAnalytics {
  final Client client;

  ApiCallGetVitalsAnalytics({required this.client});

  @override
  Future<List<ModelAnalytics>> getAnalyticsData({
    required Map<String, dynamic> data,
  }) async {
    Response response = await client.request.get(
      ApiPath.vitalsAnalytics,
      queryParameters: data,
    );
    final dataList = response.data as List<dynamic>;
    List<ModelAnalytics> analyticsData = dataList
        .map((voter) =>
        ModelAnalytics.fromJson(voter as Map<String, dynamic>))
        .toList();
    return analyticsData;
  }
}
