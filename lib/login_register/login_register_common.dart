import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: constant_identifier_names
const String LOGO_URL =
    "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fbkimg.cdn.bcebos.com%2Fpic%2F622762d0f703918fa0ec73c4cb75319759ee3d6d6e2e&refer=http%3A%2F%2Fbkimg.cdn.bcebos.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1646370850&t=e312d981c20620f708c85b70aee6e981";

Widget getHeader(Function()? closePage, Function()? callService) {
  var topPadding = MediaQuery.of(Get.context!).padding.top;
  return Padding(
      padding: EdgeInsets.only(
          left: 20.w, top: topPadding, right: 20.w, bottom: 20.w),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: closePage,
            child: const Icon(Icons.close, color: Colors.black87)),
        InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: callService,
            child: Text("online_service".tr,
                style: TextStyle(color: Colors.black87, fontSize: 20.sp)))
      ]));
}

Widget getLogo() {
  return Container(
      width: 80.r,
      height: 80.r,
      decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(40.r))),
      child: CachedNetworkImage(
          color: Colors.white, imageUrl: LOGO_URL, fit: BoxFit.cover));
}

//获取输入行
Widget getTextFieldLine(double? height, String hintTxt,
    TextEditingController? controller, FocusNode? focusNode,
    {int maxLines = 1,
    TextInputType textInputType = TextInputType.text,
    bool isObscureText = false}) {
  return Container(
      height: height,
      margin: EdgeInsets.only(left: 20.w, right: 20.w),
      padding: EdgeInsets.only(top: 20.w, bottom: 20.w),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
      child: TextField(
          obscureText: isObscureText,
          controller: controller,
          focusNode: focusNode,
          keyboardType: textInputType,
          textInputAction: TextInputAction.next,
          maxLines: maxLines,
          style: TextStyle(color: Colors.black87, fontSize: 16.sp),
          decoration: InputDecoration(
              //包裹控件（垂直方向，不然会偏移），很重要！！！
              isDense: true,
              //内容padding为空
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              hintText: hintTxt,
              hintStyle:
                  TextStyle(color: Colors.grey.shade500, fontSize: 16.sp))));
}

Widget getForgetRegisterLine(Function()? doForget, Function()? doRegister) {
  return Padding(
      padding: EdgeInsets.all(20.w),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: doForget,
            child: Text("forget_password".tr,
                style: TextStyle(color: Colors.black87, fontSize: 16.sp))),
        InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: doRegister,
            child: Text("register_account".tr,
                style: TextStyle(color: Colors.black87, fontSize: 16.sp)))
      ]));
}

Widget getLoginBtn(Function()? doLogin) {
  return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: doLogin,
      child: Container(
        width: 375.w - 80.w,
        height: 50.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(Radius.circular(10.r))),
        child: Text("login".tr,
            style: TextStyle(color: Colors.white, fontSize: 16.sp)),
      ));
}
