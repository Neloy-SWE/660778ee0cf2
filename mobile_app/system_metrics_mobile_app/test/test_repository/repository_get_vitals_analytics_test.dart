/* 
Created by Neloy on 01 February, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:system_metrics_mobile_app/data/api/api_call_get_vitals_analytics.dart';
import 'package:system_metrics_mobile_app/data/client/client_constant.dart';
import 'package:system_metrics_mobile_app/data/model/model_analytics.dart';
import 'package:system_metrics_mobile_app/data/repository/repository_get_vitals_analytics.dart';

class MockApiCall extends Mock implements IApiCallGetVitalsAnalytics {}

void main() {
  late MockApiCall apiCall;
  late RepositoryGetVitalsAnalytics repository;

  setUp(() {
    apiCall = MockApiCall();
    repository = RepositoryGetVitalsAnalytics(
      apiCallGetVitalsAnalytics: apiCall,
    );
  });

  List<ModelAnalytics> analyticsData = [];

  group("repository: /api/vitals/analytics: get", () {
    test("success", () async {
      when(
        () => apiCall.getAnalyticsData(data: any(named: "data")),
      ).thenAnswer((_) async => analyticsData);

      var (a, b) = await repository.getAnalytics(deviceId: "device_id");
      expect(a, equals(analyticsData));
      verify(
        () => apiCall.getAnalyticsData(data: any(named: "data")),
      ).called(1);
    });

    test("fail:", () async {
      when(
        () => apiCall.getAnalyticsData(data: any(named: "data")),
      ).thenThrow(Exception());

      var (a, b) = await repository.getAnalytics(deviceId: "device_id");
      expect(b, equals(ClientConstant.dataFetchedFailed));
      verify(
        () => apiCall.getAnalyticsData(data: any(named: "data")),
      ).called(1);
    });
  });
}
