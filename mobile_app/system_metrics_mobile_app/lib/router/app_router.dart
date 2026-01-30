/* 
Created by Neloy on 28 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:system_metrics_mobile_app/data/repository/repository_get_vitals.dart';
import 'package:system_metrics_mobile_app/data/repository/repository_get_vitals_analytics.dart';
import 'package:system_metrics_mobile_app/data/repository/repository_post_vitals.dart';
import 'package:system_metrics_mobile_app/presentation/screen/dashboard/bloc/bloc_dashboard.dart';
import 'package:system_metrics_mobile_app/presentation/screen/dashboard/screen_dashboard.dart';
import 'package:system_metrics_mobile_app/presentation/screen/history/bloc/analytics/bloc_analytics.dart';
import 'package:system_metrics_mobile_app/presentation/screen/history/bloc/history_list/bloc_history_list.dart';
import 'package:system_metrics_mobile_app/presentation/screen/history/screen_history.dart';

import '../Dependency/service_injection.dart';
import '../presentation/screen/splash/screen_splash.dart';

final GlobalKey<NavigatorState> navigator = GlobalKey();

class AppRouter {
  static const String screenSplash = "/screenSplash";
  static const String screenDashboard = "/screenDashboard";
  static const String screenHistory = "/screenHistory";
}

final GoRouter appRouter = GoRouter(
  navigatorKey: navigator,
  initialLocation: AppRouter.screenSplash,
  routes: [
    GoRoute(
      path: AppRouter.screenSplash,
      builder: (context, state) => ScreenSplash(),
    ),

    GoRoute(
      path: AppRouter.screenDashboard,
      builder: (context, state) => BlocProvider<BlocDashboard>(
        create: (_) => BlocDashboard(
          repositoryPostVitals: serviceInjector<IRepositoryPostVitals>(),
        ),
        child: ScreenDashboard(),
      ),
    ),

    GoRoute(
      path: AppRouter.screenHistory,
      builder: (context, state) => MultiBlocProvider(
        providers: [
          BlocProvider<BlocAnalytics>(
            create: (_) => BlocAnalytics(
              repositoryGetVitalsAnalytics:
                  serviceInjector<IRepositoryGetVitalsAnalytics>(),
            ),
          ),
          BlocProvider<BlocHistoryList>(
            create: (_) => BlocHistoryList(
              repositoryGetVitals: serviceInjector<IRepositoryGetVitals>(),
            ),
          ),
        ],
        child: ScreenHistory(deviceId: state.extra as String),
      ),
    ),
  ],
);
