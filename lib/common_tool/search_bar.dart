import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget getHomeSearchBar() {
  return Container(
      padding: EdgeInsets.fromLTRB(0, 8.h, 0, 8.h),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 20.r, color: Colors.black38),
            SizedBox(width: 10.w),
            //国际化
            Text("search_text".tr,
                style: TextStyle(color: Colors.black38, fontSize: 14.sp))
          ]),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          color: Colors.grey.shade300));
}
