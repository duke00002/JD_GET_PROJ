import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget getTitle(String title) {
  return Padding(
      padding: EdgeInsets.all(10.w),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(width: 5.w, height: 20.h, color: Colors.red),
            SizedBox(width: 10.w),
            Text(title,
                style: TextStyle(color: Colors.black87, fontSize: 14.sp))
          ]));
}
