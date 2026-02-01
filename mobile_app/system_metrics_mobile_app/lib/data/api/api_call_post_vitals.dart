/* 
Created by Neloy on 29 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';
import 'package:system_metrics_mobile_app/data/api/api_path.dart';

import '../client/client.dart';

abstract class IApiCallPostVitals {
  Future<String> addDeviceDetails({required Map<String, dynamic> data});
}

class ApiCallPostVitals extends IApiCallPostVitals {
  final Client client;

  ApiCallPostVitals({required this.client});

  @override
  Future<String> addDeviceDetails({
    required Map<String, dynamic> data,
  }) async {
    Response response = await client.request.post(ApiPath.vitals, data: data);
    return response.data;
  }
}
