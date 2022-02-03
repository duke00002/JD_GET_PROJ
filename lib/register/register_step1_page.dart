import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jd_get_proj/common_tool/phone_tool.dart';
import 'package:jd_get_proj/config/route_configs.dart';
import 'package:jd_get_proj/register/register_common.dart';

class RegisterStep1Page extends StatelessWidget {
  RegisterStep1Page({Key? key}) : super(key: key);

  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("fast_register".tr),
            centerTitle: true,
            backgroundColor: Colors.red),
        body: Container(
            padding: EdgeInsets.all(20.w),
            child: Column(children: [
              _getPhoneView(),
              SizedBox(height: 30.h),
              getNextBtn("next_step".tr, doNext),
              SizedBox(height: 20.h),
              getServiceView(callService)
            ])));
  }

  Widget _getPhoneView() {
    return Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.all(Radius.circular(2.r))),
        child: Row(children: [
          Text("+86", style: TextStyle(color: Colors.black87, fontSize: 14.sp)),
          Icon(Icons.arrow_drop_down, color: Colors.grey, size: 24.r),
          SizedBox(width: 10.w),
          Expanded(
              child: getRegisterTextFieldLine(
                  "enter_phone_number".tr, _controller, _focusNode,
                  textInputType: TextInputType.phone))
        ]));
  }

  void doNext() {
    //收起键盘
    _focusNode.unfocus();
    //判断手机号是否合法
    var phone = _controller.text;
    if (!isChinaPhoneLegal(phone)) {
      Fluttertoast.showToast(msg: "phone_is_not_legal".tr);
      return;
    }
    //传到下一页
    Get.toNamed(REGISTER_STEP2_PATH, parameters: {"phone": phone});
  }
}
