import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jd_get_proj/models/cart_item_model.dart';
import 'package:jd_get_proj/models/transport_item_model.dart';
import 'package:jd_get_proj/rest_tools/rest_api.dart';

Widget getNoAddress(Function()? addAddressTap) {
  return InkWell(
      onTap: addAddressTap,
      child: Container(
          width: 375.w,
          height: 80.h,
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
          alignment: Alignment.center,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Icon(Icons.add_circle, color: Colors.grey),
            Text("add_your_address".tr,
                style: TextStyle(color: Colors.black87, fontSize: 16.sp)),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey)
          ])));
}

Widget getDefaultAddressView(
    TransportItemModel transportItemModel, openAddresses) {
  return InkWell(
      onTap: openAddresses,
      child: Container(
          width: 375.w,
          height: 80.h,
          color: Colors.white,
          padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
          child: Row(children: [
            Expanded(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text("${transportItemModel.name} ${transportItemModel.phone}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black87, fontSize: 16.sp)),
                  SizedBox(height: 5.h),
                  Text(
                      "${transportItemModel.province}${transportItemModel.city}${transportItemModel.district}${transportItemModel.address}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.black87, fontSize: 16.sp)),
                ])),
            SizedBox(width: 10.w),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey)
          ])));
}

Widget getOrderListView(List<CartItemModel> cartItems) {
  List<Widget> items = [];
  var productItemsList = cartItems.map((e) {
    return getOrderProductLine(e);
  }).toList();

  items.addAll(productItemsList);
  items.add(Container(height: 20.w, color: Colors.white));
  items.add(SizedBox(height: 10.w));
  items.add(getTotalPriceAndDiscount(cartItems));

  return ListView(children: items);
}

//生成商品单行组件
Widget getOrderProductLine(CartItemModel cartItemModel) {
  String url = "${RestApi.host}/${cartItemModel.image!.replaceAll("\\", "/")}";
  return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 20.w, left: 20.w, right: 20.w),
      child: Row(children: [
        CachedNetworkImage(
            imageUrl: url, width: 80.w, height: 80.w, fit: BoxFit.cover),
        SizedBox(width: 10.w),
        Expanded(
            child: SizedBox(
                height: 80.w,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cartItemModel.title!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.black87, fontSize: 14.sp)),
                      Text(cartItemModel.attrs!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.grey.shade500, fontSize: 14.sp)),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("¥${cartItemModel.price}",
                                style: TextStyle(
                                    color: Colors.red, fontSize: 16.sp)),
                            Text("X${cartItemModel.count!}",
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 14.sp))
                          ])
                    ])))
      ]));
}

Widget getTotalPriceAndDiscount(List<CartItemModel> cartItems) {
  int total = 0;
  for (var element in cartItems) {
    total += element.price! * element.count!;
  }

  double discount = total * 0.2;
  return Container(
      color: Colors.white,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
            padding: EdgeInsets.fromLTRB(20.w, 20.w, 20.w, 10.w),
            child: Text("${'total_price'.tr}：¥$total${'rmb'.tr}",
                style: TextStyle(color: Colors.black87, fontSize: 14.sp))),
        Padding(
            padding: EdgeInsets.fromLTRB(20.w, 10.w, 20.w, 20.w),
            child: Text("${'discount_price'.tr}：¥$discount${'rmb'.tr}",
                style: TextStyle(color: Colors.black87, fontSize: 14.sp)))
      ]));
}

Widget getPayBottom(List<CartItemModel> cartItems, Function()? onOrderTap) {
  int total = 0;
  for (var element in cartItems) {
    total += element.price! * element.count!;
  }
  double discount = total * 0.2;
  //实际支付
  double pay = total - discount;

  return Container(
      height: 70.w,
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade300))),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
            child: Row(children: [
          Text('real_pay'.tr,
              style: TextStyle(color: Colors.black87, fontSize: 16.sp)),
          Text("¥$pay${'rmb'.tr}",
              style: TextStyle(color: Colors.red, fontSize: 18.sp))
        ])),
        InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: onOrderTap,
            child: Container(
                width: 100.w,
                height: 40.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(20.w))),
                child: Text("order_now".tr,
                    style: TextStyle(color: Colors.white, fontSize: 16.sp))))
      ]));
}
