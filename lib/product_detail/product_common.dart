import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jd_get_proj/models/product_detail_model.dart';
import 'package:jd_get_proj/product_detail/product_attr_widgets.dart';
import 'package:get/get.dart';

Widget getBtn(String title, Color color, Function()? onTap) {
  return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Container(
          width: 120.w,
          height: 40.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(10.r))),
          child: Text(title,
              style: TextStyle(color: Colors.white, fontSize: 14.sp))));
}

Widget getCartBtn(String title, Function()? onTap) {
  return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Icon(Icons.shopping_cart),
        Text(title, style: TextStyle(color: Colors.black87, fontSize: 14.sp))
      ]));
}

Widget getSheetBtn(String btn1Title, String btn2Title, Color btn1Color,
    Color btn2Color, Function()? onTap1, Function()? onTap2) {
  return Expanded(
      child: Container(
          alignment: Alignment.bottomCenter,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            getAttrBtn(btn1Title, btn1Color, Colors.white, onTap1),
            getAttrBtn(btn2Title, btn2Color, Colors.white, onTap2)
          ])));
}

Widget getAttrRow(Attr e, List<Color> Function(String attrValue) getColorList,
    Function(String key, String value) setTempSelectedAttr) {
  //属性的标题
  var titleText = getAttrTitle(e.cate!);
  //属性的选项列
  var subAttrs = e.list!.map((element) {
    //根据所选的属性，来返回显示的颜色
    var colorList = getColorList(element);
    return getAttrLabel(element, colorList[0], colorList[1], () {
      setTempSelectedAttr(e.cate!, element);
    });
  }).toList();

  return Padding(
      padding: EdgeInsets.only(bottom: 20.w),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        titleText,
        Expanded(
            child: Wrap(spacing: 10.w, runSpacing: 10.w, children: subAttrs))
      ]));
}

Widget getCountRow(
    String title, int count, Function()? onMinus, Function()? onPlus) {
  //属性的标题
  var titleText = getAttrTitle(title);
  return Padding(
      padding: EdgeInsets.fromLTRB(0, 10.w, 0, 10.w),
      child: Row(children: [
        titleText,
        getCountBtn("-", onMinus),
        getCountTxt(count),
        getCountBtn("+", onPlus)
      ]));
}

Widget getCountBtn(String title, Function()? onTap) {
  return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
          width: 30.w,
          height: 30.w,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey.shade300)),
          child: Text(title,
              style: TextStyle(color: Colors.black87, fontSize: 14.sp))));
}

Widget getCountTxt(int count) {
  return Container(
      width: 30.w,
      height: 30.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: Colors.grey.shade300),
              bottom: BorderSide(color: Colors.grey.shade300))),
      child: Text("$count",
          style: TextStyle(color: Colors.black87, fontSize: 14.sp)));
}

Widget getPrice(int? price, String? oldPrice) {
  return Padding(
      padding: EdgeInsets.all(10.w),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          Text("special_price".tr,
              style: TextStyle(color: Colors.black87, fontSize: 14.sp)),
          Text("¥$price", style: TextStyle(color: Colors.red, fontSize: 24.sp))
        ]),
        Row(children: [
          Text("old_price".tr,
              style: TextStyle(color: Colors.black87, fontSize: 14.sp)),
          Text("¥$oldPrice",
              style: TextStyle(color: Colors.grey, fontSize: 14.sp))
        ])
      ]));
}
