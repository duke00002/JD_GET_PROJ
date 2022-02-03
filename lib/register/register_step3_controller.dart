import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jd_get_proj/config/route_configs.dart';
import 'package:jd_get_proj/data_tool/shared_preferences_tool.dart';
import 'package:jd_get_proj/database/db_common.dart';
import 'package:jd_get_proj/events/event_bus.dart';
import 'package:jd_get_proj/models/user_login_model.dart';
import 'package:jd_get_proj/rest_tools/my_net_error.dart';
import 'package:jd_get_proj/rest_tools/rest_api.dart';

class RegisterStep3Controller extends GetxController {
  static RegisterStep3Controller get to => Get.find<RegisterStep3Controller>();

  final TextEditingController controller = TextEditingController();
  final FocusNode focusNode = FocusNode();

  late String _tel;
  late String _code;

  var isObscureText = true.obs;

  @override
  void onInit() {
    super.onInit();
    _tel = Get.parameters["tel"]!;
    _code = Get.parameters["code"]!;
  }

  void onChanged(bool? value) {
    //不能使用这个value,永远是true !!!
    isObscureText.value = !isObscureText.value;
  }

  void done() {
    //取消焦点
    focusNode.unfocus();
    String pwd = controller.text;
    if (pwd == "" || pwd.length < 6 || pwd.length > 20) {
      Fluttertoast.showToast(msg: "enter_right_password".tr);
      return;
    }
    //call 注册API
    _doRegister(pwd);
  }

  //注册
  void _doRegister(String pwd) async {
    try {
      var userLoginModel = await RestApi.register(
          body: {"tel": _tel, "password": pwd, "code": _code});

      if (userLoginModel.success!) {
        //出错
        if (userLoginModel.userinfo == null ||
            userLoginModel.userinfo!.isEmpty) {
          //显示错误信息
          Fluttertoast.showToast(msg: "unknown error".tr);
        } else {
          Fluttertoast.showToast(msg: userLoginModel.message!);
          var user = userLoginModel.userinfo![0];
          //存储并初始化数据库
          _saveAndInitDb(user);
        }
      } else {
        //显示错误
        Fluttertoast.showToast(msg: userLoginModel.message!);
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

  void _saveAndInitDb(Userinfo user) async {
    //保存用户信息
    bool success = await SharedPreferencesTool.saveString(
        "user", json.encode(user.toJson()));
    if (success) {
      //数据库初始化，生成表
      if (await createTables()) {
        //发送刷新用户信息广播
        eventBus.fire(RefreshUser());
        //弹出页面直到首页---》Get.until 很重要！！！
        Get.until((route) => Get.currentRoute == HOME_ALL_PATH);
      } else {
        Fluttertoast.showToast(msg: "unknown error".tr);
      }
    } else {
      Fluttertoast.showToast(msg: "unknown error".tr);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
