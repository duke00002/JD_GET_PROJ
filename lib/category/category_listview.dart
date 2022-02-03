import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jd_get_proj/models/category_model.dart';

Widget getCategoryListView(List<CategoryResult> categories, int selectedIndex,
    Function(int index) onTapped) {
  return ListView.separated(
      itemBuilder: (context, index) {
        return InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              onTapped(index);
            },
            child: Container(
                alignment: Alignment.center,
                height: 50.h,
                color:
                    selectedIndex == index ? Colors.transparent : Colors.white,
                child: Text(categories[index].title ?? "no_data".tr,
                    style: TextStyle(
                        color:
                            selectedIndex == index ? Colors.red : Colors.black,
                        fontSize: 14.sp))));
      },
      separatorBuilder: (context, index) {
        return Divider(height: 1.w, color: Colors.grey.shade500);
      },
      itemCount: categories.length);
}
