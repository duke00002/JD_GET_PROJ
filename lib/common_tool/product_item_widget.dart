import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:jd_get_proj/models/products.dart';
import 'package:jd_get_proj/rest_tools/rest_api.dart';
import 'package:get/get.dart';

Widget getProductItem(ProductResult product, Function(String id) onTap) {
  String title = product.title ?? "no_data".tr;
  String tempPath = product.sPic ?? "";
  String url = "${RestApi.host}/${tempPath.replaceAll("\\", "/")}";
  double price = (product.price ?? 0).toDouble();
  return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () {
        onTap(product.sId!);
      },
      child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CachedNetworkImage(
                    imageUrl: url,
                    width: 60.w,
                    height: 60.w,
                    fit: BoxFit.cover),
                SizedBox(width: 10.w),
                Expanded(
                    child: SizedBox(
                        height: 60.w,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(title,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black54, fontSize: 14.sp)),
                              Text("¥${price.toStringAsFixed(1)}",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 14.sp))
                            ])))
              ])));
}
