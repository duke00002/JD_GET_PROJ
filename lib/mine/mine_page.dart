import 'package:flutter/material.dart';
import 'package:jd_get_proj/mine/mine_common.dart';
import 'package:jd_get_proj/mine/mine_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MinePage extends StatelessWidget {
  const MinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Column占据顶部了
    return Column(children: [
      //用户信息
      _getHeader(),
      //菜单项
      Expanded(child: getMenuListView(MineController.to.onMenuTap))
    ]);
  }

  Widget _getHeader() {
    return Obx(() {
      return _getMineInfoView();
    });
  }

  Widget _getMineInfoView() {
    return Container(
        height: 180.h,
        padding: EdgeInsets.all(20.w),
        decoration: getBoxDecoration(BK_URL),
        child: MineController.to.userinfo.value.sId == null
            ? getEmptyView(
                UNLOGIN_ICON, "login_register".tr, MineController.to.onLoginTap)
            : getUserView(MineController.to.userinfo.value,
                MineController.to.onAccountTap));
  }
}
