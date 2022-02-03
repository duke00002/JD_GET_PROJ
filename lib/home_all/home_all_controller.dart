import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jd_get_proj/cart/cart_controller.dart';
import 'package:jd_get_proj/cart/cart_page.dart';
import 'package:jd_get_proj/category/category_page.dart';
import 'package:jd_get_proj/events/event_bus.dart';
import 'package:jd_get_proj/home/home_page.dart';
import 'package:jd_get_proj/mine/mine_page.dart';

List<Widget> pages = [
  const HomePage(),
  const CategoryPage(),
  const CartPage(),
  const MinePage()
];

class HomeAllController extends GetxController {
  //获取绑定的HomeController对象
  static HomeAllController get to => Get.find<HomeAllController>();

  PageController pageController = PageController();

  var index = 0.obs;

  void updateIndexAndMovePage(int selectedIndex) {
    index.value = selectedIndex;
    pageController.jumpToPage(selectedIndex);
    //重新读取一次数据并刷新
    if (selectedIndex == 2) {
      CartController.to.queryAll();
    }
  }

  void updateTabIndex(int selectedIndex) {
    index.value = selectedIndex;
  }

  late StreamSubscription jumpSubscription;

  @override
  void onInit() {
    super.onInit();
    //监听广播事件
    jumpSubscription = eventBus.on<JumpToTabEvent>().listen((event) {
      //切换到购物车页面
      updateIndexAndMovePage(event.tabIndex);
    });
  }

  @override
  void onClose() {
    //取消监听广播事件
    jumpSubscription.cancel();
    super.onClose();
  }
}
