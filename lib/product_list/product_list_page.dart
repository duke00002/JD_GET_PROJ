import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jd_get_proj/common_tool/product_item_widget.dart';
import 'package:jd_get_proj/product_list/product_list_controller.dart';
import 'package:jd_get_proj/product_list/product_tab_bar.dart';
import 'package:jd_get_proj/search/search_bar.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _getAppBar(),
        body: Obx(() {
          //SmartRefresher子元素必须为：ListView，所以--》Obx 必须放外层
          return SmartRefresher(
              enablePullDown: ProductListController.to.enablePullDown,
              enablePullUp: ProductListController.to.enablePullUp,
              header: ProductListController.to.refreshHeader,
              footer: ProductListController.to.loadFooter,
              controller: ProductListController.to.refreshController,
              onRefresh: ProductListController.to.doRefresh,
              onLoading: ProductListController.to.doLoadMore,
              child: _getListView());
        }));
  }

  AppBar _getAppBar() {
    if (ProductListController.to.cid != null) {
      return AppBar(
          title: Text("product_list".tr),
          centerTitle: true,
          bottom: getProductTabBar(
              Colors.white,
              Colors.black54,
              TabBarIndicatorSize.tab,
              ProductListController.to.sortList,
              ProductListController.to.tabController,
              ProductListController.to.tabBarTapped));
    } else {
      return getSearchBar(
          getProductTabBar(
              Colors.white,
              Colors.black54,
              TabBarIndicatorSize.tab,
              ProductListController.to.sortList,
              ProductListController.to.tabController,
              ProductListController.to.tabBarTapped),
          ProductListController.to.focusNode,
          ProductListController.to.textEditingController,
          ProductListController.to.searchTapped,
          ProductListController.to.onSubmitted);
    }
  }

  Widget _getListView() {
    return ListView.separated(
        itemBuilder: (context, index) {
          return getProductItem(ProductListController.to.sortProducts[index],
              ProductListController.to.goDetail);
        },
        separatorBuilder: (context, index) {
          return Divider(height: 1, color: Colors.grey.shade200);
        },
        itemCount: ProductListController.to.sortProducts.length);
  }
}
