import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:jd_get_proj/models/focus_model.dart';
import 'package:jd_get_proj/rest_tools/rest_api.dart';

Widget getSwiper(List<FocusResult> focuses, Function(int index) onTap) {
  return Swiper(
      //页面个数
      itemCount: focuses.length,
      //页面itemBuilder
      itemBuilder: (context, index) {
        String urlPath = focuses[index].pic ?? ""; //;
        String url = "${RestApi.host}/${urlPath.replaceAll("\\", "/")}";
        return CachedNetworkImage(imageUrl: url, fit: BoxFit.cover);
      },
      //自动播放
      autoplay: true,
      //画面停顿5000毫秒
      autoplayDelay: 3000,
      //画面切换时间1000毫秒
      duration: 800,
      //循环播放
      loop: true,
      // indicatorLayout: PageIndicatorLayout.COLOR,

      //指示器设置：SwiperPagination
      pagination: const SwiperPagination(
          //指示器位置
          alignment: Alignment.bottomCenter,
          //指示器 margin
          margin: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
          //指示器三种样式：DotSwiperPaginationBuilder，FractionPaginationBuilder，RectSwiperPaginationBuilder
          builder: DotSwiperPaginationBuilder(
              //指示器未选中颜色
              color: Colors.white,
              //指示器选中颜色
              activeColor: Colors.blue,
              //未选中大小
              size: 10.0,
              //选中大小
              activeSize: 10.0,
              //指示器间距
              space: 5.0)),
      //点击
      onTap: onTap);
}
