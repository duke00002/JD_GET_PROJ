import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jd_get_proj/home_all/bar_config.dart';
import 'package:jd_get_proj/home_all/home_all_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return BottomNavigationBar(
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          iconSize: 24.r,
          selectedFontSize: 14.sp,
          unselectedFontSize: 14.sp,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          onTap: (index) {
            HomeAllController.to.updateIndexAndMovePage(index);
          },
          currentIndex: HomeAllController.to.index.value,
          items: _getItems());
    });
  }

  List<BottomNavigationBarItem> _getItems() {
    return BOTTOM_BAR.map((e) {
      String title = (e["title"] as String).tr;
      IconData iconData = e["icon"] as IconData;

      return BottomNavigationBarItem(icon: Icon(iconData), label: title);
    }).toList();
  }
}
