import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget getAttrTitle(String title) {
  return Padding(
      padding: EdgeInsets.fromLTRB(0, 10.w, 0, 10.w),
      child: Text("$title：",
          style: TextStyle(
              color: Colors.black87,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold)));
}

Widget getAttrLabel(
    String label, Color bkColor, Color txtColor, Function()? onTap) {
  return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
          padding: EdgeInsets.fromLTRB(20.w, 10.w, 20.w, 10.w),
          decoration: BoxDecoration(
              color: bkColor,
              borderRadius: BorderRadius.all(Radius.circular(20.r))),
          child:
              Text(label, style: TextStyle(color: txtColor, fontSize: 14.sp))));
}

Widget getAttrBtn(
    String title, Color bkColor, Color txtColor, Function()? onTap) {
  return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
          width: 160.w,
          height: 40.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: bkColor,
              borderRadius: BorderRadius.all(Radius.circular(10.r))),
          child:
              Text(title, style: TextStyle(color: txtColor, fontSize: 14.sp))));
}
