/* 
Created by Neloy on 29 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:system_metrics_mobile_app/core/app_size.dart';
import 'package:system_metrics_mobile_app/core/app_text.dart';
import 'package:system_metrics_mobile_app/data/model/model_history_list.dart';
import 'package:system_metrics_mobile_app/presentation/custom_widget/custom_date_picker.dart';
import 'package:system_metrics_mobile_app/presentation/custom_widget/custom_failed_widget.dart';
import 'package:system_metrics_mobile_app/presentation/custom_widget/custom_snack_bar.dart';
import 'package:system_metrics_mobile_app/presentation/custom_widget/loader/custom_loader_analytics.dart';
import 'package:system_metrics_mobile_app/presentation/custom_widget/loader/custom_loader_history.dart';
import 'package:system_metrics_mobile_app/presentation/screen/history/bloc/analytics/bloc_analytics.dart';
import 'package:system_metrics_mobile_app/presentation/screen/history/bloc/history_list/bloc_history_list.dart';

import '../../../core/app_color.dart';
import '../../../tool/tool_grid_fixed_height_delegate.dart';

class ScreenHistory extends StatefulWidget {
  final String deviceId;

  const ScreenHistory({super.key, required this.deviceId});

  @override
  State<ScreenHistory> createState() => _ScreenHistoryState();
}

class _ScreenHistoryState extends State<ScreenHistory> {
  String fromDateFormatted = AppText.selectDate;
  DateTime? fromDateQuery;
  bool isFromDataClear = false;

  String toDateFormatted = AppText.selectDate;
  DateTime? toDateQuery;
  bool isToDataClear = false;

  bool isAnalyticsReload = false;
  bool isHistoryReload = false;

  ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _loadAnalyticsData();
    _loadHistory();

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        _loadHistoryMore();
      }
    });

    super.initState();
  }

  void _loadAnalyticsData() {
    context.read<BlocAnalytics>().add(
      EventGetAnalytics(
        deviceId: widget.deviceId,
        dateFrom: fromDateQuery,
        dateTo: toDateQuery,
      ),
    );
  }

  void _loadHistory() {
    context.read<BlocHistoryList>().add(EventGetHistoryList());
  }

  void _loadHistoryMore() {
    context.read<BlocHistoryList>().add(EventHistoryListLoadMore());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppText.history)),
      body: SafeArea(
        child: ListView(
          controller: scrollController,
          padding: EdgeInsets.all(25),
          children: [
            CustomDatePicker(
              title: AppText.from,
              onTapCalender: _dateSelectFrom,
              onTapClearField: _dateClearFrom,
              dateData: fromDateFormatted,
              isDataClear: isFromDataClear,
            ),
            AppSize.gapH15,
            CustomDatePicker(
              title: AppText.to,
              onTapCalender: _dateSelectTo,
              onTapClearField: _dateClearTo,
              dateData: toDateFormatted,
              isDataClear: isToDataClear,
            ),
            AppSize.gapH20,
            _title(
              title: AppText.analytics,
              isReload: isAnalyticsReload,
              onPressed: () {
                _dateClearFrom();
                _dateClearTo();
                _loadAnalyticsData();
                setState(() {
                  isAnalyticsReload = false;
                });
              },
            ),
            AppSize.gapH10,

            BlocConsumer<BlocAnalytics, StateAnalytics>(
              listener: (context, state) {
                if (state is StateAnalyticsFail) {
                  setState(() {
                    isAnalyticsReload = true;
                  });
                }
              },
              builder: (context, state) {
                if (state is StateAnalyticsPass) {
                  return GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: ToolGridFixedHeightDelegate(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      height: 130,
                    ),
                    itemCount: state.analyticsData.length,
                    itemBuilder: (context, index) {
                      return Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColor.colorPrimary,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: .center,
                          children: [
                            Text(
                              state.analyticsData[index].title!,
                              textAlign: .center,
                              style: AppText.style.bodySmall!.copyWith(
                                color: Colors.black,
                              ),
                            ),
                            AppSize.gapH10,
                            Text(
                              "${AppText.average}:${state.analyticsData[index].average!.toStringAsFixed(2)}",
                              style: AppText.style.bodyMedium!.copyWith(
                                fontSize: 12,
                              ),
                            ),

                            Text(
                              "${AppText.maximum}:${state.analyticsData[index].maximum}",
                              style: AppText.style.bodyMedium!.copyWith(
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "${AppText.minimum}:${state.analyticsData[index].minimum}",
                              style: AppText.style.bodyMedium!.copyWith(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (state is StateAnalyticsFail) {
                  return CustomFailedWidget(message: state.message);
                } else {
                  return CustomLoaderAnalytics();
                }
              },
            ),
            AppSize.gapH20,
            _title(
              title: AppText.history,
              isReload: isHistoryReload,
              onPressed: () {
                _loadHistory();
                setState(() {
                  isHistoryReload = false;
                });
              },
            ),
            AppSize.gapH10,
            BlocConsumer<BlocHistoryList, StateHistoryList>(
              listener: (context, state) {
                if (state is StateHistoryListLoadFail) {
                  setState(() {
                    isHistoryReload = true;
                  });
                } else if (state is StateHistoryListMaxLoad) {
                  CustomSnackBar.show(
                    context: context,
                    contentText: state.message,
                  );
                }
              },
              builder: (context, state) {
                if (state is StateHistoryListLoadPass ||
                    state is StateHistoryListMaxLoad ||
                    state is StateHistoryListExtending) {
                  List<History> items = context.watch<BlocHistoryList>().items;
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColor.colorPrimary,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: .start,
                          children: [
                            Text(
                              DateFormat.yMMMd().format(
                                items[index].timestamp!.toLocal(),
                              ),
                              style: AppText.style.bodyLarge,
                            ),
                            AppSize.gapH10,
                            Wrap(
                              children: [
                                Text(
                                  "${AppText.memoryUsageColon}${items[index].memoryUsage}%",
                                  style: AppText.style.bodyMedium,
                                ),
                                AppSize.gapW10,
                                Text(
                                  "${AppText.batteryLevelColon}${items[index].batteryLevel}%",
                                  style: AppText.style.bodyMedium,
                                ),
                                AppSize.gapW10,
                                Text(
                                  "${AppText.thermalValueColon}${items[index].thermalValue}%",
                                  style: AppText.style.bodyMedium,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return AppSize.gapH10;
                    },
                  );
                } else if (state is StateHistoryListLoadFail) {
                  return CustomFailedWidget(message: state.message);
                } else {
                  return CustomLoaderHistory();
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _title({
    required String title,
    required bool isReload,
    required void Function()? onPressed,
  }) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Row(
          children: [
            Text(title, style: AppText.style.bodyLarge),
            isReload
                ? IconButton(
                    onPressed: onPressed,
                    icon: Icon(
                      Icons.refresh_outlined,
                      color: AppColor.colorSecondary,
                    ),
                  )
                : AppSize.noGap,
          ],
        ),
        Divider(color: AppColor.colorPrimary),
      ],
    );
  }

  Future<void> _dateSelectFrom() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime.now(),
    );
    setState(() {
      fromDateFormatted = DateFormat.yMMMd().format(pickedDate!);
      fromDateQuery = pickedDate.toUtc();
      isFromDataClear = true;
    });
    _loadAnalyticsData();
  }

  Future<void> _dateSelectTo() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1800),
      lastDate: DateTime.now(),
    );
    setState(() {
      toDateFormatted = DateFormat.yMMMd().format(pickedDate!);
      toDateQuery = pickedDate.toUtc();
      isToDataClear = true;
    });
    _loadAnalyticsData();
  }

  void _dateClearFrom() {
    setState(() {
      fromDateFormatted = AppText.selectDate;
      fromDateQuery = null;
      isFromDataClear = false;
    });
    _loadAnalyticsData();
  }

  void _dateClearTo() {
    setState(() {
      toDateFormatted = AppText.selectDate;
      toDateQuery = null;
      isToDataClear = false;
    });
    _loadAnalyticsData();
  }
}
