import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jd_get_proj/models/products.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jd_get_proj/rest_tools/rest_api.dart';

Widget getHomeHorizontalListview(List<ProductResult> productResultList,
    Function(ProductResult productResult) onTapped) {
  return Container(
      width: 375.w,
      height: 85.h,
      padding: EdgeInsets.fromLTRB(10.w, 0, 10.w, 0),
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) =>
              getHomeHotItem(productResultList[index], onTapped),
          //定义横向ListView item之间的间距
          separatorBuilder: (context, index) => VerticalDivider(
              //横向间距设置
              width: 10.w,
              color: Colors.white),
          itemCount: productResultList.length));
}

Widget getHomeHotItem(ProductResult productResult,
    Function(ProductResult productResult) onTapped) {
  String title = productResult.title ?? "无名称";
  String tempPath = productResult.sPic ?? "";
  String url = "${RestApi.host}/${tempPath.replaceAll("\\", "/")}";
  return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        onTapped(productResult);
      },
      child: SizedBox(
          width: 50.w,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CachedNetworkImage(
                    imageUrl: url,
                    width: 50.w,
                    height: 50.w,
                    fit: BoxFit.cover),
                SizedBox(height: 10.w),
                Text(title,
                    style: TextStyle(color: Colors.black87, fontSize: 12.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis)
              ])));
}
