import 'package:flutter/material.dart';
import 'package:jd_get_proj/home_all/bottom_navigation_bar_widget.dart';
import 'package:jd_get_proj/home_all/home_all_controller.dart';

class HomeAllPage extends StatelessWidget {
  const HomeAllPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView.builder(
            controller: HomeAllController.to.pageController,
            //不允许滑动手势
            physics: const NeverScrollableScrollPhysics(),
            onPageChanged: (index) {
              HomeAllController.to.updateTabIndex(index);
            },
            itemBuilder: (context, index) {
              return pages[index];
            },
            itemCount: pages.length),
        bottomNavigationBar: const BottomNavigationBarWidget());
  }
}
