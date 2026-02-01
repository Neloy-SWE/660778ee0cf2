/* 
Created by Neloy on 31 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:system_metrics_mobile_app/data/api/api_call_get_vitals.dart';
import 'package:system_metrics_mobile_app/data/client/client_constant.dart';
import 'package:system_metrics_mobile_app/data/model/model_history_list.dart';
import 'package:system_metrics_mobile_app/data/repository/repository_get_vitals.dart';

class MockApiCall extends Mock implements IApiCallGetVitals {}

void main() {
  late MockApiCall apiCall;
  late RepositoryGetVitals repository;

  setUp(() {
    apiCall = MockApiCall();
    repository = RepositoryGetVitals(apiCallGetVitals: apiCall);
  });

  final model = ModelHistoryList(
    items: [],
    totalCount: 1,
    pageSize: 1,
    pageNumber: 1,
  );

  group("repository: /api/vitals: get", () {
    test("Success:", () async {
      when(
        () => apiCall.getHistory(data: any(named: "data")),
      ).thenAnswer((_) async => model);

      var (a, b) = await repository.getHistoryList(
        deviceId: "device_id",
        pageNumber: 1,
        pageSize: 10,
      );
      expect(a, equals(model));
      verify(() => apiCall.getHistory(data: any(named: "data"))).called(1);
    });

    test("Fail", () async {
      when(
        () => apiCall.getHistory(data: any(named: "data")),
      ).thenThrow(Exception());
      // ).thenThrow(DioException(requestOptions: RequestOptions(path: "")));

      var (a, b) = await repository.getHistoryList(
        deviceId: "device_id",
        pageNumber: 1,
        pageSize: 10,
      );
      expect(b, ClientConstant.dataFetchedFailed);
      verify(() => apiCall.getHistory(data: any(named: "data"))).called(1);
    });
  });
}
