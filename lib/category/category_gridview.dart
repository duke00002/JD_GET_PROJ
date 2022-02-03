import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jd_get_proj/models/category_model.dart';
import 'package:jd_get_proj/rest_tools/rest_api.dart';

Widget getCategoryGridView(
    List<CategoryResult> categories, Function(int index) onTapped) {
  return GridView.builder(
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (context, index) {
        CategoryResult categoryResult = categories[index];
        String title = categoryResult.title ?? "no_data".tr;
        String tempPath = categoryResult.pic ?? "";
        String url = "${RestApi.host}/${tempPath.replaceAll("\\", "/")}";

        return InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              onTapped(index);
            },
            child: Container(
                color: Colors.white,
                alignment: Alignment.center,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CachedNetworkImage(
                          imageUrl: url,
                          width: 50.w,
                          height: 50.w,
                          fit: BoxFit.cover),
                      SizedBox(height: 10.h),
                      Text(title,
                          style:
                              TextStyle(color: Colors.black87, fontSize: 14.sp))
                    ])));
      },
      itemCount: categories.length);
}
