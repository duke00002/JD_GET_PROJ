import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jd_get_proj/models/user_login_model.dart';
import 'package:jd_get_proj/models/user_model.dart';
import 'package:get/get.dart';

// ignore: constant_identifier_names
const String BK_URL =
    "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic176.nipic.com%2Ffile%2F20180810%2F7259105_084016738233_2.jpg&refer=http%3A%2F%2Fpic176.nipic.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1646316536&t=cd3ae5ae7adfd453831147ba306ed2c9";

// ignore: constant_identifier_names
const String UNLOGIN_ICON =
    "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fitem%2F202005%2F07%2F20200507184355_By5mf.thumb.1000_0.jpeg&refer=http%3A%2F%2Fc-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1646320342&t=f3c62525323acb576df0579a7263652b";

// ignore: constant_identifier_names
const String HEADER_ICON =
    "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fc-ssl.duitang.com%2Fuploads%2Fblog%2F202008%2F24%2F20200824113219_kpdwt.thumb.400_0.png&refer=http%3A%2F%2Fc-ssl.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1646316488&t=d883846f688705b436f93f7b0bf5fd60";

// ignore: constant_identifier_names
const String SERVICE_PHONE = "tel:+8618616827991";

// ignore: constant_identifier_names
const String LEVEL = "普通会员";

// ignore: non_constant_identifier_names
List<List<dynamic>> MENUS = [
  ["all_orders".tr, Icons.book, Colors.red],
  ["wait_pay".tr, Icons.credit_card, Colors.green],
  ["wait_receiving".tr, Icons.car_rental, Colors.amber],
  ["my_favorite".tr, Icons.star, Colors.pink],
  ["online_service".tr, Icons.room_service, Colors.grey]
];

getBoxDecoration(String url) {
  return BoxDecoration(
      image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover));
}

getClipOval(String imageUrl) {
  return ClipOval(
      child: CachedNetworkImage(
          imageUrl: imageUrl, fit: BoxFit.cover, width: 70.w, height: 70.w));
}

Widget getEmptyView(String iconUrl, String title, Function()? onLoginTap) {
  return Row(children: [
    getClipOval(iconUrl),
    SizedBox(width: 10.w),
    InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: onLoginTap,
        child:
            Text(title, style: TextStyle(color: Colors.white, fontSize: 18.sp)))
  ]);
}

Widget getUserView(Userinfo userinfo, Function()? onAccountTap) {
  return Row(children: [
    getClipOval(HEADER_ICON),
    SizedBox(width: 10.w),
    InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: onAccountTap,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${'user_name'.tr}${userinfo.username}",
                  style: TextStyle(color: Colors.white, fontSize: 18.sp)),
              SizedBox(height: 10.h),
              Text(LEVEL,
                  style: TextStyle(color: Colors.white, fontSize: 14.sp))
            ]))
  ]);
}

Widget getMenuListView(Function(int index) onMenuTap) {
  return ListView.separated(
      //去除ListView的顶部内边距
      padding: const EdgeInsets.only(top: 0, bottom: 0),
      itemBuilder: (context, index) {
        var data = MENUS[index];
        return InkWell(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () {
              onMenuTap(index);
            },
            child: ListTile(
                leading: Icon(data[1], color: data[2]),
                title: Text(data[0],
                    style: TextStyle(color: Colors.black87, fontSize: 14.sp))));
      },
      separatorBuilder: (context, index) {
        return Divider(height: 1, color: Colors.grey.shade400);
      },
      itemCount: MENUS.length);
}
