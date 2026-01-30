/* 
Created by Neloy on 29 January, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';

import '../../../core/app_color.dart';
import '../../../core/app_size.dart';
import '../../../tool/tool_grid_fixed_height_delegate.dart';

class CustomLoaderAnalytics extends StatelessWidget {
  const CustomLoaderAnalytics({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: ToolGridFixedHeightDelegate(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        height: 130,
      ),
      itemCount: 3,
      itemBuilder: (context, index) {
        return _loaderGridElement();
      },
    );
  }

  Widget _loaderGridElement() {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: AppColor.colorPrimary, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: .center,
        mainAxisAlignment: .center,
        children: [
          Container(height: 25, width: 40, color: AppColor.colorLoader),
          AppSize.gapH10,
          Container(height: 25, width: 60, color: AppColor.colorLoader),
        ],
      ),
    );
  }
}
