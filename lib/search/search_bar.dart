import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

AppBar getSearchBar(
    PreferredSizeWidget? bottom,
    FocusNode focusNode,
    TextEditingController controller,
    Function()? onTap,
    Function(String)? onSubmitted) {
  return AppBar(
      //设置title之间没有空隙
      titleSpacing: 0,
      //自定义title
      title: getSearchText(focusNode, controller, onSubmitted),
      bottom: bottom,
      actions: [
        InkWell(
            onTap: onTap,
            child: Container(
                margin: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
                alignment: Alignment.center,
                child: Text("search".tr,
                    style: TextStyle(color: Colors.white, fontSize: 14.sp))))
      ]);
}

Widget getSearchText(FocusNode focusNode, TextEditingController controller,
    Function(String)? onSubmitted) {
  return Container(
      width: double.infinity,
      height: 32.h,
      // margin: EdgeInsets.fromLTRB(0, 0, 20.w, 0),
      padding: EdgeInsets.fromLTRB(15.w, 0, 15.w, 0),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(20.r))),
      //输入框
      child: TextField(
          //控制关闭的：focusNode
          focusNode: focusNode,
          //控制器，获取值用的
          controller: controller,
          //自动吊起键盘
          autofocus: false,
          //键盘回车
          textInputAction: TextInputAction.search,
          //输入字体
          style: TextStyle(color: Colors.black87, fontSize: 14.sp),
          decoration: InputDecoration(
              //isDense: true + contentPadding: EdgeInsets.zero ---》保证垂直方向上内容不偏离
              isDense: true,
              //输入内容的Padding
              contentPadding: EdgeInsets.zero,
              //输入边框为空
              border: InputBorder.none,
              //提示内容
              hintText: "search_hint".tr,
              //提示内容风格
              hintStyle:
                  TextStyle(color: Colors.grey.shade400, fontSize: 14.sp)),
          // onChanged: (text) {
          //   // print(text);
          // },
          onSubmitted: onSubmitted));
}
