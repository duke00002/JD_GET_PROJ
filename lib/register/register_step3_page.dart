import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jd_get_proj/register/register_common.dart';
import 'package:jd_get_proj/register/register_step3_controller.dart';

class RegisterStep3Page extends StatelessWidget {
  const RegisterStep3Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("fast_register".tr),
            centerTitle: true,
            backgroundColor: Colors.red),
        body: Container(
            padding: EdgeInsets.all(20.w),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _getPwdLine(),
              SizedBox(height: 10.h),
              //观察密码可见
              Obx(() {
                return _getPwdView();
              }),
              //观察密码可见
              Obx(() {
                return _getCheckView();
              }),
              _getNoticeView(),
              SizedBox(height: 30.h),
              //完成按钮
              getNextBtn("done".tr, RegisterStep3Controller.to.done),
              SizedBox(height: 20.h),
              //客服按钮
              getServiceView(callService)
            ])));
  }

  Widget _getPwdLine() {
    return Text("set_password".tr,
        style: TextStyle(
            color: Colors.black87,
            fontSize: 12.sp,
            fontWeight: FontWeight.bold));
  }

  Widget _getPwdView() {
    return Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.all(Radius.circular(2.r))),
        //观察是否显示密码
        child: getRegisterTextFieldLine(
            "enter_6_20_characters".tr,
            RegisterStep3Controller.to.controller,
            RegisterStep3Controller.to.focusNode,
            isObscureText: RegisterStep3Controller.to.isObscureText.value));
  }

  Widget _getCheckView() {
    return Row(children: [
      Theme(
          data: ThemeData(
              //未选中边框色
              unselectedWidgetColor: Colors.grey,
              //点击色处理
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent),
          child: Checkbox(
              //选中勾的颜色
              checkColor: Colors.white,
              //选中背景色
              activeColor: Colors.red,
              value: !RegisterStep3Controller.to.isObscureText.value,
              onChanged: RegisterStep3Controller.to.onChanged)),
      Text("show_password".tr,
          style: TextStyle(color: Colors.black87, fontSize: 14.sp))
    ]);
  }

  Widget _getNoticeView() {
    return Text("password_notice".tr,
        style: TextStyle(color: Colors.grey.shade500, fontSize: 12.sp));
  }
}
