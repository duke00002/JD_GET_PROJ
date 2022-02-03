import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jd_get_proj/config/route_configs.dart';
import 'package:jd_get_proj/models/product_detail_model.dart';
import 'package:jd_get_proj/product_detail/product_common.dart';
import 'package:jd_get_proj/product_detail/product_detail_comment.dart';
import 'package:jd_get_proj/product_detail/product_detail_controller.dart';
import 'package:jd_get_proj/product_detail/product_detail_info.dart';
import 'package:jd_get_proj/product_detail/product_detail_web.dart';
import 'package:jd_get_proj/product_list/product_tab_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailPage extends StatelessWidget {
  const ProductDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: getProductTabBar(
                Colors.transparent,
                Colors.white,
                TabBarIndicatorSize.label,
                ProductDetailController.to.sortList,
                ProductDetailController.to.tabController,
                ProductDetailController.to.tabBarTapped),
            actions: [
              IconButton(onPressed: _showMenu, icon: const Icon(Icons.menu))
            ]),
        body: Column(children: [
          Expanded(child: _getPageView()),
          Divider(height: 1, color: Colors.grey.shade500),
          SizedBox(
              width: 375.w,
              height: 70.h,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    getCartBtn("cart".tr, ProductDetailController.to.toCart),
                    getBtn("add_cart".tr, Colors.red, _addCart),
                    getBtn("buy_now".tr, Colors.amber,
                        ProductDetailController.to.buyNow)
                  ]))
        ]));
  }

  Widget _getPageView() {
    //检查下载结果,obx
    return Obx(() {
      return _makePageView(
          ProductDetailController.to.detailModel.value.productDetailResult);
    });
  }

  Widget _makePageView(ProductDetailResult? productDetailResult) {
    List<Widget> list = [];
    //如果结果为空，则显示空页面
    if (productDetailResult == null) {
      for (var _ in ProductDetailController.to.sortList) {
        list.add(Container(color: Colors.white));
      }
    } else {
      //不为空显示的页面
      list.add(const ProductDetailInfo());
      list.add(const ProductDetailWeb());
      list.add(const ProductDetailComment());
    }

    return PageView(
        controller: ProductDetailController.to.pageController,
        onPageChanged: ProductDetailController.to.onPageChanged,
        children: list);
  }

  //显示菜单
  void _showMenu() async {
    //选择的值
    var value = await showMenu<String>(
        //获取当前Context：Get.context
        context: Get.context!,
        //相对于屏幕的弹出位置（菜单左上角）
        position: RelativeRect.fromLTRB(275.w, 90.h, 10.w, 0),
        items: [
          //弹出菜单
          PopupMenuItem(
              //菜单的值
              value: "home",
              child: Row(children: [
                const Icon(Icons.home),
                Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
                    child: Text("home".tr))
              ])),
          //弹出菜单
          PopupMenuItem(
              //菜单的值
              value: "search",
              child: Row(children: [
                const Icon(Icons.search),
                Padding(
                    padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 0),
                    child: Text("search".tr))
              ]))
        ]);

    if (value == "home") {
      //返回首页
      Get.offAllNamed(HOME_ALL_PATH);
    } else if (value == "search") {
      //跳转到商品列表页（无参数）
      Get.toNamed(PRODUCTS_PATH);
    }
  }

  //弹出购物车界面
  void _addCart() async {
    var result = await Get.bottomSheet(
        Container(
            height: 400.h,
            padding: EdgeInsets.fromLTRB(10.w, 20.w, 10.w, 20.w),
            //这边需要观察，暂时选中的需要改变颜色
            child: Obx(() {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _getBottomSheetContent());
            })),
        backgroundColor: Colors.white);

    //证明是点击了空白处收起
    if (result == null) {
      //取消属性选定
      ProductDetailController.to.cancelAttrAndCountNoClose();
    }
  }

  //底部弹出属性菜单
  List<Widget> _getBottomSheetContent() {
    //获取商品属性列表
    var attrlist =
        ProductDetailController.to.detailModel.value.productDetailResult!.attr!;
    //属性行（多行）
    var attrRows = attrlist.map((e) {
      //获得属性行
      return getAttrRow(e, ProductDetailController.to.getAttrColor,
          ProductDetailController.to.setTempSelectedAttr);
    }).toList();
    //按钮组件
    var btnView = getSheetBtn(
        "add_cart".tr,
        "buy_now".tr,
        Colors.red,
        Colors.amber,
        ProductDetailController.to.addToCart,
        ProductDetailController.to.buyNowAndClose);

    //返回组件列表
    List<Widget> views = [];
    views.addAll(attrRows);
    views.add(Divider(color: Colors.grey.shade400, height: 1));
    views.add(getCountRow(
        "buy_count".tr,
        ProductDetailController.to.count.value,
        ProductDetailController.to.onMinusTap,
        ProductDetailController.to.onPlusTap));

    views.add(btnView);
    return views;
  }
}
