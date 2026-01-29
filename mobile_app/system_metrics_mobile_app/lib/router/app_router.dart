/* 
Created by Neloy on 28 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:system_metrics_mobile_app/data/repository/repository_post_vitals.dart';
import 'package:system_metrics_mobile_app/presentation/screen/dashboard/bloc/bloc_dashboard.dart';
import 'package:system_metrics_mobile_app/presentation/screen/dashboard/screen_dashboard.dart';

import '../Dependency/service_injection.dart';
import '../presentation/screen/splash/screen_splash.dart';

final GlobalKey<NavigatorState> navigator = GlobalKey();

class AppRouter {
  static const String screenSplash = "/screenSplash";
  static const String screenDashboard = "/screenDashboard";
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
  ],
);
