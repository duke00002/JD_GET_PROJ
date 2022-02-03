import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jd_get_proj/register/register_common.dart';
import 'package:jd_get_proj/register/register_step2_controller.dart';

class RegisterStep2Page extends StatelessWidget {
  const RegisterStep2Page({Key? key}) : super(key: key);

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
              _getPhoneLine(),
              SizedBox(height: 10.h),
              Row(children: [
                Expanded(child: _getPincodeView()),
                SizedBox(width: 10.w),
                //监听按钮标题显示的变化
                Obx(() {
                  return getPinCodeBtn(
                      RegisterStep2Controller.to.btnTitle.value,
                      RegisterStep2Controller.to.onPincodeTap);
                })
              ]),
              SizedBox(height: 20.h),
              getNextBtn("next_step".tr, RegisterStep2Controller.to.doNext),
              SizedBox(height: 20.h),
              getServiceView(callService)
            ])));
  }

  Widget _getPhoneLine() {
    return Text(
        "${'enter'.tr}${RegisterStep2Controller.to.phone}${'pincode'.tr}",
        style: TextStyle(
            color: Colors.black87,
            fontSize: 12.sp,
            fontWeight: FontWeight.bold));
  }

  Widget _getPincodeView() {
    return Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.all(Radius.circular(2.r))),
        child: getRegisterTextFieldLine(
            "enter_pincode".tr,
            RegisterStep2Controller.to.controller,
            RegisterStep2Controller.to.focusNode,
            textInputType: TextInputType.phone,
            isObscureText: true));
  }
}
