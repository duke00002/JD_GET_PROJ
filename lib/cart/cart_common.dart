import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jd_get_proj/models/cart_item_model.dart';
import 'package:jd_get_proj/product_detail/product_common.dart';
import 'package:jd_get_proj/rest_tools/rest_api.dart';

Widget getEmptyView() {
  return Container(
      alignment: Alignment.center,
      child: Text("no_data".tr,
          style: TextStyle(color: Colors.black87, fontSize: 30.sp)));
}

Widget getSettleView(bool checked, Function(bool?)? onChanged,
    Function()? onTap, int totalPrice) {
  return Container(
      width: 375.w,
      height: 50.h,
      padding: EdgeInsets.only(left: 5.w),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade200))),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(children: [
          Theme(
              data: ThemeData(
                  //未选中边框色
                  unselectedWidgetColor: Colors.grey,
                  //点击色处理
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent),
              child: Checkbox(
                  //选中勾的颜色
                  checkColor: Colors.white,
                  //选中背景色
                  activeColor: Colors.red,
                  value: checked,
                  onChanged: onChanged)),
          Text("check_all".tr,
              style: TextStyle(color: Colors.black87, fontSize: 14.sp)),
          SizedBox(width: 10.w),
          Text("¥$totalPrice",
              style: TextStyle(color: Colors.red, fontSize: 18.sp))
        ]),
        InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: onTap,
            child: Container(
                width: 100.w,
                color: Colors.red,
                alignment: Alignment.center,
                child: Text("settle".tr,
                    style: TextStyle(color: Colors.white, fontSize: 14.sp))))
      ]));
}

Widget getSlidableView(
    CartItemModel cartItemModel,
    Function()? onDelete,
    Function()? onItemTap,
    Function(bool?)? onItemCheckChanged,
    Function()? onMinus,
    Function()? onPlus) {
  //横向滑动按钮组件
  return Slidable(
      //尾部触发组件
      endActionPane: ActionPane(
          //行为滑动
          motion: const ScrollMotion(),
          //占item的百分比显示滑动按钮(划出宽度)
          extentRatio: 100.w / (375.w - 20.w),
          children: [
            Container(
                width: 100.w,
                //高度不设，相当于顶格
                // height: ,
                margin: EdgeInsets.fromLTRB(0, 5.h, 0, 5.h),
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(5.r))),
                child: Row(children: [
                  //如果嵌套：外层必须是支持flex的父控件（如Row或Column ）！！！
                  //滑动按钮
                  SlidableAction(
                      flex: 1,
                      onPressed: (context) {
                        onDelete!();
                      },
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      // icon: Icons.archive,
                      label: 'delete'.tr)
                ]))
          ]),
      child: getCard(
          cartItemModel, onItemTap, onItemCheckChanged, onMinus, onPlus));
}

//生成Card组件布局
Widget getCard(
    CartItemModel cartItemModel,
    Function()? onItemTap,
    Function(bool?)? onItemCheckChanged,
    Function()? onMinus,
    Function()? onPlus) {
  String url = "${RestApi.host}/${cartItemModel.image!.replaceAll("\\", "/")}";
  //点击事件不可加在card外部，会隐藏效果
  return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onItemTap,
      child: Card(
          // Card的背景色，默认白色
          color: Colors.white,
          // Card的阴影色 !!!
          // shadowColor: Colors.grey
          // Card的阴影的厚度 !!!
          elevation: 2.h,
          //控制Card的边框属性（颜色，粗细，圆角弧度）!!!
          // margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.r))),
          //点击事件正确的包裹方式
          child: Padding(
              padding: EdgeInsets.all(10.w),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Theme(
                        data: ThemeData(
                            //未选中边框色
                            unselectedWidgetColor: Colors.grey,
                            //点击色处理
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent),
                        child: Checkbox(
                            //选中勾的颜色
                            checkColor: Colors.white,
                            //选中背景色
                            activeColor: Colors.red,
                            value: cartItemModel.checked,
                            onChanged: onItemCheckChanged)),
                    SizedBox(width: 10.w),
                    CachedNetworkImage(
                        imageUrl: url,
                        width: 80.w,
                        height: 80.w,
                        fit: BoxFit.cover),
                    SizedBox(width: 10.w),
                    Expanded(
                        child: SizedBox(
                            height: 80.w,
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(cartItemModel.title!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 14.sp)),
                                  Text(cartItemModel.attrs!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.grey.shade500,
                                          fontSize: 14.sp)),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("¥${cartItemModel.price}",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 16.sp)),
                                        Row(children: [
                                          getCountBtn("-", onMinus),
                                          getCountTxt(cartItemModel.count!),
                                          getCountBtn("+", onPlus)
                                        ])
                                      ])
                                ])))
                  ]))));
}
