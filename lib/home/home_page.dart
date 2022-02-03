import 'package:flutter/material.dart';
import 'package:jd_get_proj/common_tool/app_bar_widget.dart';
import 'package:jd_get_proj/home/home_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jd_get_proj/home/home_gridview.dart';
import 'package:jd_get_proj/home/home_horizontal_listview.dart';
import 'package:jd_get_proj/home/home_swiper.dart';
import 'package:jd_get_proj/home/home_title.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

//AutomaticKeepAliveClientMixin 保持当前页状态
class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    //添加一下段，不然会提示警告
    super.build(context);
    return Scaffold(
        appBar: AppBarWidget.getAppBar(
            HomeController.to.openScanner,
            HomeController.to.goSearchPage,
            HomeController.to.messageCount.value,
            HomeController.to.goMessagePage),
        body: _getListView());
  }

  Widget _getListView() {
    return ListView(
        shrinkWrap: true,
        children: [_getSwiper(), _getHorizontalList(), _getGridView()]);
  }

  Widget _getSwiper() {
    return AspectRatio(
        aspectRatio: 16.0 / 9.0,
        child: Obx(() {
          return HomeController.to.focuses.isNotEmpty
              ? getSwiper(HomeController.to.focuses, HomeController.to.goFocus)
              : const SizedBox();
        }));
  }

  Widget _getHorizontalList() {
    return Obx(() {
      return HomeController.to.hots.isNotEmpty
          ? Column(children: [
              getTitle("hot".tr),
              getHomeHorizontalListview(
                  HomeController.to.hots, HomeController.to.goProductDetail)
            ])
          : SizedBox(width: 0.h);
    });
  }

  Widget _getGridView() {
    return Obx(() {
      return HomeController.to.bests.isNotEmpty
          ? Column(children: [
              getTitle("best".tr),
              getHomeGridView(
                  HomeController.to.bests, HomeController.to.goProductDetail)
            ])
          : SizedBox(width: 0.h);
    });
  }

  //AutomaticKeepAliveClientMixin 保持当前页状态
  @override
  bool get wantKeepAlive => true;
}
