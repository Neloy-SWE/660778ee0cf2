/* 
Created by Neloy on 31 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:system_metrics_mobile_app/data/api/api_call_post_vitals.dart';
import 'package:system_metrics_mobile_app/data/client/client_constant.dart';
import 'package:system_metrics_mobile_app/data/model/model_system_metrics.dart';
import 'package:system_metrics_mobile_app/data/repository/repository_post_vitals.dart';

class MockApiCall extends Mock implements IApiCallPostVitals {}

void main() {
  late MockApiCall apiCall;
  late RepositoryPostVitals repository;

  setUp(() {
    apiCall = MockApiCall();
    repository = RepositoryPostVitals(apiCallPostVitals: apiCall);
  });

  String resultCheck = ClientConstant.created;

  ModelSystemMetrics systemMetrics = ModelSystemMetrics(
    memoryUsage: 1,
    thermalStatus: "Normal",
    thermalValue: 1,
    batteryLevel: 1,
    deviceId: "device_id",
    timestamp: DateTime.now(),
    deviceOs: "android",
  );

  group("repository: /api/vitals: post", () {
    test("success:", () async {
      when(
        () => apiCall.addDeviceDetails(data: any(named: "data")),
      ).thenAnswer((_) async => resultCheck);

      var (a, b) = await repository.addDeviceDetails(
        systemMetrics: systemMetrics,
      );
      expect(a, equals(ClientConstant.dataSavedSuccessfully));
      verify(
        () => apiCall.addDeviceDetails(data: any(named: "data")),
      ).called(1);
    });

    test("fail:", () async {
      when(
        () => apiCall.addDeviceDetails(data: any(named: "data")),
      ).thenThrow(Exception());

      var (a, b) = await repository.addDeviceDetails(
        systemMetrics: systemMetrics,
      );
      expect(b, equals(ClientConstant.networkIssue));
      verify(
        () => apiCall.addDeviceDetails(data: any(named: "data")),
      ).called(1);
    });
  });
}
