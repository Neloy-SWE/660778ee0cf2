/* 
Created by Neloy on 29 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:get_it/get_it.dart';
import 'package:system_metrics_mobile_app/data/api/api_call_get_vitals.dart';
import 'package:system_metrics_mobile_app/data/api/api_call_get_vitals_analytics.dart';
import 'package:system_metrics_mobile_app/data/api/api_call_post_vitals.dart';
import 'package:system_metrics_mobile_app/data/repository/repository_get_vitals_analytics.dart';
import 'package:system_metrics_mobile_app/data/repository/repository_post_vitals.dart';

import '../data/client/client.dart';
import '../data/repository/repository_get_vitals.dart';

final serviceInjector = GetIt.instance;

Future<void> injectService() async {
  // final sharedPreferences = await SharedPreferences.getInstance();
  // serviceInjector.registerSingleton<SharedPreferences>(sharedPreferences);

  // serviceInjector.registerSingleton<Connectivity>(Connectivity());

  serviceInjector.registerSingleton<Client>(Client());

  serviceInjector.registerSingleton<IApiCallPostVitals>(
    ApiCallPostVitals(client: serviceInjector<Client>()),
  );

  serviceInjector.registerSingleton<IRepositoryPostVitals>(
    RepositoryPostVitals(
      apiCallPostVitals: serviceInjector<IApiCallPostVitals>(),
    ),
  );

  serviceInjector.registerSingleton<IApiCallGetVitals>(
    ApiCallGetVitals(client: serviceInjector<Client>()),
  );

  serviceInjector.registerSingleton<IRepositoryGetVitals>(
    RepositoryGetVitals(apiCallGetVitals: serviceInjector<IApiCallGetVitals>()),
  );

  serviceInjector.registerSingleton<IApiCallGetVitalsAnalytics>(
    ApiCallGetVitalsAnalytics(client: serviceInjector<Client>()),
  );

  serviceInjector.registerSingleton<IRepositoryGetVitalsAnalytics>(
    RepositoryGetVitalsAnalytics(
      apiCallGetVitalsAnalytics: serviceInjector<IApiCallGetVitalsAnalytics>(),
    ),
  );
}
