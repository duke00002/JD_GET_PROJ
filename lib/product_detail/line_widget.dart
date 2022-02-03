import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget getLineWidget(String label, String value) {
  return Container(
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
      margin: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
      child: Padding(
          padding: EdgeInsets.fromLTRB(0, 20.w, 0, 20.w),
          child: Row(children: [
            Text(label,
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold)),
            Text(value,
                style: TextStyle(color: Colors.black87, fontSize: 14.sp))
          ])));
}

Widget getGenricTitle(String title, Color color, double fontSize) {
  return Padding(
      padding: EdgeInsets.fromLTRB(10.w, 10.w, 10.w, 0),
      child: Text(title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: color, fontSize: fontSize)));
}
