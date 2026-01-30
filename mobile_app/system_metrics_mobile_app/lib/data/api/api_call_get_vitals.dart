/* 
Created by Neloy on 29 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:dio/dio.dart';

import '../client/client.dart';
import 'api_path.dart';

abstract class IApiCallGetVitals {
  Future<Response> getHistory({required Map<String, dynamic> data});
}

class ApiCallGetVitals extends IApiCallGetVitals {
  final Client client;

  ApiCallGetVitals({required this.client});

  @override
  Future<Response> getHistory({required Map<String, dynamic> data}) async {
    Response response = await client.request.get(
      ApiPath.vitals,
      queryParameters: data,
    );
    return response;
  }
}
