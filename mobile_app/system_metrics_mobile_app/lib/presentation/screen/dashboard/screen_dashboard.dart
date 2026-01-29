/* 
Created by Neloy on 28 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_metrics_mobile_app/core/app_size.dart';
import 'package:system_metrics_mobile_app/core/app_text.dart';
import 'package:system_metrics_mobile_app/presentation/custom_widget/custom_button.dart';
import 'package:system_metrics_mobile_app/presentation/custom_widget/custom_failed_widget.dart';
import 'package:system_metrics_mobile_app/presentation/custom_widget/custom_simple_dialogue_loader.dart';
import 'package:system_metrics_mobile_app/presentation/custom_widget/custom_snack_bar.dart';
import 'package:system_metrics_mobile_app/presentation/screen/dashboard/bloc/bloc_dashboard.dart';

import '../../../core/app_color.dart';
import '../../custom_widget/custom_dashboard_loader.dart';

class ScreenDashboard extends StatefulWidget {
  const ScreenDashboard({super.key});

  @override
  State<ScreenDashboard> createState() => _ScreenDashboardState();
}

class _ScreenDashboardState extends State<ScreenDashboard> {
  @override
  void initState() {
    _getMetrics();
    super.initState();
  }

  void _getMetrics() {
    context.read<BlocDashboard>().add(EventGetMetrics());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppText.dashboard),
        actions: [
          IconButton(
            onPressed: _getMetrics,
            icon: Icon(Icons.refresh_outlined, color: AppColor.colorSecondary),
          ),
          AppSize.gapW20,
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<BlocDashboard, StateDashboard>(
          listener: (BuildContext context, StateDashboard state) {
            if (state is StateDashboardFail) {
              if (ModalRoute.of(context)?.isCurrent == false) {
                Navigator.of(context).pop();
              }
              CustomSnackBar.show(
                context: context,
                isError: true,
                contentText: state.message,
              );
            } else if (state is StateDashboardSaveMetricsLoad) {
              CustomSimpleDialogueLoader.show(context: context);
            } else if (state is StateDashboardSaveMetricsDone) {
              if (ModalRoute.of(context)?.isCurrent == false) {
                Navigator.of(context).pop();
              }

              CustomSnackBar.show(context: context, contentText: state.message);
            }
          },
          builder: (BuildContext context, StateDashboard state) {
            if (state is StateDashboardInitialLoad) {
              return _parent(child: CustomDashboardLoader(index: 3));
            } else if (state is StateDashboardFail) {
              return _parent(
                child: ListView(
                  children: [
                    AppSize.gapH80,
                    CustomFailedWidget(message: state.message),
                  ],
                ),
              );
            } else if (state is StateDashboardDeviceDetails ||
                state is StateDashboardSaveMetricsDone ||
                state is StateDashboardSaveMetricsLoad) {
              return _parent(
                child: ListView(
                  padding: EdgeInsets.all(25),
                  children: [
                    _metricsElement(
                      icon: Icons.phone_android_outlined,
                      title: AppText.deviceOS,
                      // value: state.systemMetrics.deviceOs!,
                      value: context
                          .read<BlocDashboard>()
                          .systemMetrics!
                          .deviceOs!,
                    ),
                    _metricsElement(
                      icon: Icons.thermostat_outlined,
                      title: AppText.thermalStaus,
                      value: context
                          .read<BlocDashboard>()
                          .systemMetrics!
                          .thermalStatus!,
                    ),
                    _metricsElement(
                      icon: Icons.thermostat_auto_outlined,
                      title: AppText.thermalValue,
                      value: context
                          .read<BlocDashboard>()
                          .systemMetrics!
                          .thermalValue
                          .toString(),
                    ),
                    _metricsElement(
                      icon: Icons.battery_charging_full_outlined,
                      title: AppText.batteryLevel,
                      value: context
                          .read<BlocDashboard>()
                          .systemMetrics!
                          .batteryLevel
                          .toString(),
                    ),
                    _metricsElement(
                      icon: Icons.memory_outlined,
                      title: AppText.memoryUsage,
                      value:
                          "${context.read<BlocDashboard>().systemMetrics!.memoryUsage}%",
                    ),

                    AppSize.gapH35,
                    CustomButton(
                      onPressed: () {
                        context.read<BlocDashboard>().add(EventSaveMetrics());
                      },
                      buttonText: AppText.logStatus,
                    ),
                  ],
                ),
              );
            } else {
              return AppSize.noGap;
            }
          },
        ),
      ),
    );
  }

  Widget _parent({required Widget child}) {
    return RefreshIndicator(
      color: AppColor.colorPrimary,
      onRefresh: () async {
        _getMetrics();
      },
      child: child,
    );
  }

  Widget _metricsElement({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Row(
          children: [
            Icon(icon, size: 35, color: AppColor.colorSecondary),
            AppSize.gapW05,
            Text(title, style: AppText.style.bodyLarge),
          ],
        ),
        Divider(color: AppColor.colorPrimary),
        Text(value, style: AppText.style.bodyMedium),
        AppSize.gapH20,
      ],
    );
  }
}
