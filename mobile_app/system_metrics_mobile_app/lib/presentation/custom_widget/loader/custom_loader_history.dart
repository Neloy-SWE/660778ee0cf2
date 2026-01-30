/* 
Created by Neloy on 29 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';

import '../../../core/app_color.dart';
import '../../../core/app_size.dart';

class CustomLoaderHistory extends StatelessWidget {
  const CustomLoaderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 3,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return _loaderListElement();
      },
      separatorBuilder: (BuildContext context, int index) {
        return AppSize.gapH15;
      },
    );
  }

  Widget _loaderListElement() {
    return Container(
      padding: EdgeInsets.all(15),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColor.colorPrimary, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Container(height: 25, width: 90, color: AppColor.colorLoader),
              Container(height: 25, width: 100, color: AppColor.colorLoader),
            ],
          ),
          AppSize.gapH10,
          Container(height: 25, width: 60, color: AppColor.colorLoader),
          AppSize.gapH10,
          Container(height: 25, color: AppColor.colorLoader),
        ],
      ),
    );
  }
}
