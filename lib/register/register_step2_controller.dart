import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jd_get_proj/config/route_configs.dart';
import 'package:jd_get_proj/rest_tools/my_net_error.dart';
import 'package:jd_get_proj/rest_tools/rest_api.dart';

class RegisterStep2Controller extends GetxController {
  static RegisterStep2Controller get to => Get.find<RegisterStep2Controller>();

  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  late String phone;
  //被观察的按钮标题
  var btnTitle = "send".tr.obs;
  //计算时间
  int _count = 60;
  //定时器
  Timer? _sendTimer;

  @override
  void onInit() {
    super.onInit();
    //获取手机号
    phone = Get.parameters["phone"]!;
  }

  void onPincodeTap() {
    //按钮为发送状态下
    if (btnTitle.value == "send".tr) {
      //发送pincode
      _sendPincode();
      //变成重新发送显示
      btnTitle.value = "${'resend'.tr}($_count)";
      //启动定时器，1秒刷新一次
      _sendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _count--;
        //时间到了
        if (_count == 0) {
          //取消定时器
          timer.cancel();
          //重置计时
          _count = 60;
          //重置按钮显示
          btnTitle.value = "send".tr;
        } else {
          //更新按钮显示
          btnTitle.value = "${'resend'.tr}($_count)";
        }
      });
    }
  }

  //发送pincode
  void _sendPincode() async {
    try {
      //获取pincode
      var pinCodeModel = await RestApi.sendPincode(body: {"tel": phone});
      if (pinCodeModel.success!) {
        //显示pincode
        Fluttertoast.showToast(
            msg: pinCodeModel.code!, toastLength: Toast.LENGTH_LONG);
      } else {
        //显示错误
        Fluttertoast.showToast(msg: pinCodeModel.message!);
      }
    } on MyNetError catch (e) {
      // ignore: avoid_print
      print("MyNetError ${e.code} ${e.message} ${e.data}");
      Fluttertoast.showToast(msg: e.message);
    } catch (e) {
      // ignore: avoid_print
      print(e);
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  //验证pincode
  void _validatePincode(String pincode) async {
    try {
      //验证pincode
      var pinCodeModel =
          await RestApi.validatePincode(body: {"tel": phone, "code": pincode});
      if (pinCodeModel.success!) {
        Fluttertoast.showToast(msg: pinCodeModel.message!);
        //去下一页!!!
        Get.toNamed(REGISTER_STEP3_PATH,
            parameters: {"tel": phone, "code": pincode});
      } else {
        //显示错误
        Fluttertoast.showToast(msg: pinCodeModel.message!);
      }
    } on MyNetError catch (e) {
      // ignore: avoid_print
      print("MyNetError ${e.code} ${e.message} ${e.data}");
      Fluttertoast.showToast(msg: e.message);
    } catch (e) {
      // ignore: avoid_print
      print(e);
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void doNext() {
    //收起键盘
    focusNode.unfocus();
    //判断pincode是否合法(4位)
    var pincode = controller.text;
    if (pincode == "") {
      Fluttertoast.showToast(msg: "enter_pincode".tr);
      return;
    }

    if (pincode.length != 4) {
      Fluttertoast.showToast(msg: "enter_right_pincode".tr);
      return;
    }
    //验证pincode
    _validatePincode(pincode);
  }

  @override
  void onClose() {
    //取消定时器
    _sendTimer?.cancel();
    super.onClose();
  }
}
