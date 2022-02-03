import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jd_get_proj/common_tool/sort_model.dart';

PreferredSizeWidget getProductTabBar(
    Color bkColor,
    Color labelColor,
    TabBarIndicatorSize? tabBarIndicatorSize,
    List<SortModel> sortModels,
    TabController controller,
    Function(int index) onTap) {
  //自定义TabBar,TabBar要改变背景色必须自定义，使用：PreferredSize
  return PreferredSize(
      //设置TabBar高度
      preferredSize: Size.fromHeight(40.h),
      child: Theme(
          data: ThemeData(
              //设置点击色
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent),
          child: Material(
              //设置背景色
              color: bkColor,
              child: TabBar(
                  indicatorSize: tabBarIndicatorSize,
                  onTap: onTap,
                  tabs: getBarItems(sortModels, labelColor),
                  controller: controller,
                  indicatorColor: Colors.red))));
}

List<Widget> getBarItems(List<SortModel> sortModels, Color labelColor) {
  return sortModels.map((e) {
    switch (e.sortType) {
      case SortType.genaric:
        return Tab(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Text(e.title,
                  style: TextStyle(color: labelColor, fontSize: 14.sp))
            ]));
      case SortType.sold:
        return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(e.title,
                  style: TextStyle(color: labelColor, fontSize: 14.sp)),
            ]);
      case SortType.price:
        return Tab(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Text(e.title,
                  style: TextStyle(color: labelColor, fontSize: 14.sp))
            ]));
      case SortType.product:
        return Tab(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Text(e.title,
                  style: TextStyle(color: labelColor, fontSize: 14.sp))
            ]));
      case SortType.product_detail:
        return Tab(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Text(e.title,
                  style: TextStyle(color: labelColor, fontSize: 14.sp))
            ]));
      case SortType.product_comment:
        return Tab(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              Text(e.title,
                  style: TextStyle(color: labelColor, fontSize: 14.sp))
            ]));
    }
  }).toList();
}
