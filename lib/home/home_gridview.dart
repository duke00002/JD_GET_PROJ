import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jd_get_proj/models/products.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jd_get_proj/rest_tools/rest_api.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget getHomeGridView(List<ProductResult> productResultList,
    Function(ProductResult productResult) onTapped) {
  return Container(
      //整屏
      width: 375.w,
      padding: EdgeInsets.all(10.w),
      child: GridView.builder(
          itemCount: productResultList.length,
          itemBuilder: (context, index) =>
              getHomeBestItem(productResultList[index], onTapped),
          //必须有
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //列数
              crossAxisCount: 2,
              //纵向间距
              crossAxisSpacing: 10.w,
              //横向间距
              mainAxisSpacing: 10.w,
              //子元素比例
              childAspectRatio: 0.7),
          //不可滚动
          physics: const NeverScrollableScrollPhysics(),
          //展开
          shrinkWrap: true));
}

Widget getHomeBestItem(ProductResult productResult,
    Function(ProductResult productResult) onTapped) {
  String title = productResult.title ?? "no_data".tr;
  String tempPath = productResult.sPic ?? "";
  String url = "${RestApi.host}/${tempPath.replaceAll("\\", "/")}";

  double price = (productResult.price ?? 0).toDouble();
  double oldPrice = double.parse(productResult.oldPrice ?? "0");

  return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        onTapped(productResult);
      },
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade200, width: 1.w),
              borderRadius: BorderRadius.all(Radius.circular(5.r))),
          padding: EdgeInsets.all(10.w),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                    aspectRatio: 1,
                    child:
                        CachedNetworkImage(imageUrl: url, fit: BoxFit.cover)),
                Text(title,
                    style:
                        TextStyle(color: Colors.grey.shade600, fontSize: 12.sp),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("¥${price.toStringAsFixed(1)}",
                          style: TextStyle(color: Colors.red, fontSize: 16.sp),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis),
                      oldPrice == 0
                          ? const SizedBox(width: 0)
                          : Text("¥${oldPrice.toStringAsFixed(1)}",
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough,
                                  color: Colors.black54,
                                  fontSize: 12.sp),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis)
                    ])
              ])));
}
