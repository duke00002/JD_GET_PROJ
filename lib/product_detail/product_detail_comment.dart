import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailComment extends StatelessWidget {
  const ProductDetailComment({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Text("product_comment".tr,
            style: TextStyle(color: Colors.black87, fontSize: 30.sp)));
  }
}
