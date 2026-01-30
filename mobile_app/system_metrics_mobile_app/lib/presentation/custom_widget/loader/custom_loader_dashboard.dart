/* 
Created by Neloy on 28 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:system_metrics_mobile_app/core/app_color.dart';
import 'package:system_metrics_mobile_app/core/app_size.dart';

class CustomLoaderDashboard extends StatelessWidget {
  final int index;

  const CustomLoaderDashboard({super.key, this.index = 3});

  @override
  Widget build(BuildContext context) {
    // return Padding(
    //   padding: const EdgeInsets.all(25),
    // child: Column(
    //   children: [for (int i = 0; i < index; i++) _loaderElement()],
    // ),
    return ListView.separated(
      padding: EdgeInsets.all(25),
      itemCount: index,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return _loaderElement();
      },
      separatorBuilder: (BuildContext context, int index) {
        return AppSize.gapH10;
      },
    );
  }

  Widget _loaderElement() {
    return Container(
      padding: EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColor.colorPrimary, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(height: 25, width: 60, color: AppColor.colorLoader),
              AppSize.gapW20,
              Container(height: 25, width: 130, color: AppColor.colorLoader),
            ],
          ),
          AppSize.gapH10,
          Container(height: 25, color: AppColor.colorLoader),
        ],
      ),
    );
  }
}
