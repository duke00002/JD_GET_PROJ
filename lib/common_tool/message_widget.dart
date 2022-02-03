import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget getMessageWidget(int messageCount) {
  return Padding(
      padding: EdgeInsets.only(left: 15.w, right: 10.w),
      child: Stack(children: [
        Align(
            alignment: Alignment.center,
            child: Icon(Icons.message_outlined,
                color: Colors.black87, size: 32.r)),
        Positioned(
            top: 5.h,
            right: 0,
            child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(5.h, 2.h, 5.h, 2.h),
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(10.r))),
                child: Text("$messageCount",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold))))
      ]));
}

Future<bool> showDialog(
    String title, String content, String textConfirm, String textCancel) async {
  var result = await Get.defaultDialog<bool>(
      title: title,
      titleStyle: TextStyle(color: Colors.blue, fontSize: 18.sp),
      content: Text(content,
          style: TextStyle(color: Colors.black87, fontSize: 16.sp)),
      onConfirm: () {
        //相当于pop,并返回结果
        Get.back(result: true);
      },
      // onCancel: () {},
      radius: 10.r,
      textConfirm: textConfirm,
      textCancel: textCancel,
      confirmTextColor: Colors.white);

  if (result == null || !result) {
    return false;
  }

  return true;
}
