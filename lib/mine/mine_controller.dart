import 'dart:async';
import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jd_get_proj/common_tool/message_widget.dart';
import 'package:jd_get_proj/common_tool/user_tool.dart';
import 'package:jd_get_proj/config/route_configs.dart';
import 'package:jd_get_proj/data_tool/shared_preferences_tool.dart';
import 'package:jd_get_proj/events/event_bus.dart';
import 'package:jd_get_proj/mine/mine_common.dart';
import 'package:jd_get_proj/models/user_login_model.dart';
import 'package:jd_get_proj/models/user_model.dart';
import 'package:url_launcher/url_launcher.dart';

class MineController extends GetxController {
  static MineController get to => Get.find<MineController>();

  var userinfo = Userinfo.init().obs;

  late StreamSubscription<RefreshUser> _streamSubscription;

  @override
  void onInit() {
    super.onInit();
    //初始化获取用户信息
    _getUserInfo();
    //监听刷新用户广播,返回句柄
    _streamSubscription = eventBus.on<RefreshUser>().listen((event) {
      //刷新用户信息
      _getUserInfo();
    });
  }

  void _getUserInfo() async {
    var userString = await SharedPreferencesTool.getString("user");
    if (userString == null) {
      //更新obs,空用户
      userinfo(Userinfo.init());
    } else {
      //更新obs，真用户
      userinfo(await getUser());
    }
  }

  void onLoginTap() async {
    var result = await Get.toNamed(LOGIN_REGISTER_PATH);
    if (result != null && result) {
      //刷新用户信息
      _getUserInfo();
    }
  }

  //退出登录
  void onAccountTap() async {
    //弹框提示
    var result =
        await showDialog("notice".tr, "logout".tr, "confirm".tr, "cancel".tr);
    //如果确定
    if (result) {
      //删除用户信息
      await SharedPreferencesTool.delete("user");
      //更新obs
      userinfo(Userinfo.init());
    }
  }

  void onMenuTap(int index) {
    if (userinfo.value.sId == null) {
      _doToast("please_login".tr);
      return;
    }

    switch (index) {
      case 0:
        _doToast(MENUS[index][0]);
        break;
      case 1:
        _doToast(MENUS[index][0]);
        break;
      case 2:
        _doToast(MENUS[index][0]);
        break;
      case 3:
        _doToast(MENUS[index][0]);
        break;
      case 4:
        _call();
        break;
    }
  }

  void _doToast(String msg) {
    Fluttertoast.showToast(msg: msg);
  }

  void _call() async {
    await canLaunch(SERVICE_PHONE)
        ? await launch(SERVICE_PHONE)
        : throw '不能拨打电话';
  }

  @override
  void onClose() {
    //关闭广播接收器
    _streamSubscription.cancel();
    super.onClose();
  }
}
