//获取输入行
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jd_get_proj/mine/mine_common.dart';
import 'package:url_launcher/url_launcher.dart';

Widget getRegisterTextFieldLine(
    String hintTxt, TextEditingController? controller, FocusNode? focusNode,
    {int maxLines = 1,
    TextInputType textInputType = TextInputType.text,
    bool isObscureText = false}) {
  return TextField(
      obscureText: isObscureText,
      controller: controller,
      focusNode: focusNode,
      keyboardType: textInputType,
      textInputAction: TextInputAction.done,
      maxLines: maxLines,
      style: TextStyle(color: Colors.black87, fontSize: 14.sp),
      decoration: InputDecoration(
          //包裹控件（垂直方向，不然会偏移），很重要！！！
          isDense: true,
          //内容padding为空
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
          hintText: hintTxt,
          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14.sp)));
}

Widget getNextBtn(String title, Function()? onBtnTap) {
  return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onBtnTap,
      child: Container(
          width: 375.w - 40.w,
          height: 50.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.all(Radius.circular(2.r))),
          child: Text(title,
              style: TextStyle(color: Colors.white, fontSize: 16.sp))));
}

Widget getPinCodeBtn(String title, Function()? onBtnTap) {
  Color bkColor;
  Color titleColor;
  if (title == "send".tr) {
    bkColor = Colors.red;
    titleColor = Colors.white;
  } else {
    bkColor = Colors.grey.shade300;
    titleColor = Colors.grey.shade500;
  }

  return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onBtnTap,
      child: Container(
          width: 100.w,
          height: 40.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: bkColor,
              borderRadius: BorderRadius.all(Radius.circular(2.r))),
          child: Text(title,
              style: TextStyle(color: titleColor, fontSize: 14.sp))));
}

Widget getServiceView(Function()? callService) {
  return Row(children: [
    Text("question_ask".tr,
        style: TextStyle(color: Colors.grey.shade500, fontSize: 12.sp)),
    InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: callService,
        child: Text("call_service".tr,
            style: TextStyle(
                color: Colors.black87,
                fontSize: 12.sp,
                decoration: TextDecoration.underline)))
  ]);
}

void callService() async {
  await canLaunch(SERVICE_PHONE) ? await launch(SERVICE_PHONE) : throw '不能拨打电话';
}
