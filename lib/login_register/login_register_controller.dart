import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jd_get_proj/config/route_configs.dart';
import 'package:jd_get_proj/data_tool/shared_preferences_tool.dart';
import 'package:jd_get_proj/database/db_common.dart';
import 'package:jd_get_proj/mine/mine_common.dart';
import 'package:jd_get_proj/models/user_login_model.dart';
import 'package:jd_get_proj/rest_tools/my_net_error.dart';
import 'package:jd_get_proj/rest_tools/rest_api.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginRegisterController extends GetxController {
  static LoginRegisterController get to => Get.find<LoginRegisterController>();

  TextEditingController accountOrPhoneController = TextEditingController();
  FocusNode accountOrPhoneFocusNode = FocusNode();

  TextEditingController pwdController = TextEditingController();
  FocusNode pwdFocusNode = FocusNode();

  @override
  void onInit() {
    super.onInit();
  }

  void closePage() {
    //取消焦点
    accountOrPhoneFocusNode.unfocus();
    pwdFocusNode.unfocus();
    Get.back();
  }

  void callService() async {
    //取消焦点
    accountOrPhoneFocusNode.unfocus();
    pwdFocusNode.unfocus();

    await canLaunch(SERVICE_PHONE)
        ? await launch(SERVICE_PHONE)
        : throw '不能拨打电话';
  }

  void doForget() {
    //取消焦点
    accountOrPhoneFocusNode.unfocus();
    pwdFocusNode.unfocus();
  }

  void doRegister() {
    //取消焦点
    accountOrPhoneFocusNode.unfocus();
    pwdFocusNode.unfocus();
    Get.toNamed(REGISTER_STEP1_PATH);
  }

  void doLogin() {
    //取消焦点
    accountOrPhoneFocusNode.unfocus();
    pwdFocusNode.unfocus();
    //判断输入是否正确
    String userName = accountOrPhoneController.text;
    String pwd = pwdController.text;

    if (userName == "") {
      Fluttertoast.showToast(msg: "enter_account_phone".tr);
      return;
    }

    if (pwd == "") {
      Fluttertoast.showToast(msg: "enter_right_password".tr);
      return;
    }
    //执行登录
    _login(userName, pwd);
  }

  //注册
  void _login(String username, String password) async {
    try {
      var userLoginModel = await RestApi.login(
          body: {"username": username, "password": password});

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
        //回到首页，并要求刷新
        Get.back<bool>(result: true);
      } else {
        Fluttertoast.showToast(msg: "unknown error".tr);
      }
    } else {
      Fluttertoast.showToast(msg: "unknown error".tr);
    }
  }

  @override
  void onClose() {
    //释放资源
    accountOrPhoneController.dispose();
    pwdController.dispose();
    super.onClose();
  }
}
