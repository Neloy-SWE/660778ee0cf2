/* 
Created by Neloy on 29 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';

import '../client/client.dart';
import 'api_path.dart';

abstract class IApiCallGetVitalsAnalytics {
  Future<Response> getAnalyticsData({required Map<String, dynamic> data});
}

class ApiCallGetVitalsAnalytics extends IApiCallGetVitalsAnalytics {
  final Client client;

  ApiCallGetVitalsAnalytics({required this.client});

  @override
  Future<Response<dynamic>> getAnalyticsData({
    required Map<String, dynamic> data,
  }) async {
    Response response = await client.request.get(
      ApiPath.vitalsAnalytics,
      queryParameters: data,
    );
    return response;
  }
}
