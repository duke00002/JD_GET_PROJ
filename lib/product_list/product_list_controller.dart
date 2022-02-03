import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jd_get_proj/common_tool/get_sortmodels.dart';
import 'package:jd_get_proj/common_tool/sort_model.dart';
import 'package:jd_get_proj/config/route_configs.dart';
import 'package:jd_get_proj/data_tool/shared_preferences_tool.dart';
import 'package:jd_get_proj/models/products.dart';
import 'package:jd_get_proj/rest_tools/my_net_error.dart';
import 'package:jd_get_proj/rest_tools/rest_api.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//GetSingleTickerProviderStateMixin 可以替代：SingleTickerProviderStateMixin
class ProductListController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static ProductListController get to => Get.find<ProductListController>();

  static const String searchHistory = "SearchHistory";
  //输入框焦点控制
  final FocusNode focusNode = FocusNode();
  //输入框控制器
  late TextEditingController textEditingController;
  //下拉刷新控制器
  final RefreshController refreshController =
      RefreshController(initialRefresh: true);
  //开启下拉刷新
  final bool enablePullDown = true;
  //开启上拉加载
  final bool enablePullUp = true;
  //刷新头设置
  final refreshHeader = const MaterialClassicHeader();
  //加载尾部设置
  final loadFooter = ClassicFooter(
      loadingText: "loadingText".tr,
      noDataText: "noDataText".tr,
      failedText: "failedText".tr,
      idleText: "pull_up_load".tr,
      canLoadingText: "release_to_load_more".tr);
  //Tab控制器
  late TabController tabController;
  //筛选项
  var sortList = getSortList();
  //当前搜索模式
  late SortModel sortModel;
  //分类cid
  String? cid;
  //搜索内容
  String? search;
  //当前页码
  int page = 1;
  //加载数量（每页）
  static const int pageSize = 10;
  //商品列表
  RxList<ProductResult> sortProducts = <ProductResult>[].obs;

  @override
  void onInit() {
    super.onInit();
    cid = Get.parameters["cid"];
    search = Get.parameters["search"];
    tabController = TabController(length: sortList.length, vsync: this);
    textEditingController = TextEditingController(text: search);
    sortModel = sortList[0];
  }

  void tabBarTapped(int index) {
    //先清除所有的，因为切换了
    sortProducts.clear();
    //当前搜索类型
    sortModel = sortList[index];
    //要求刷新
    refreshController.requestRefresh(needMove: false);
  }

  void searchTapped() {
    onSubmitted(textEditingController.text);
  }

  void onSubmitted(String txt) async {
    //收起键盘，失去焦点
    focusNode.unfocus();
    if (txt.trim() != "") {
      //保存搜索记录
      var searchList = await SharedPreferencesTool.getStringList(searchHistory);
      searchList ??= <String>[];
      if (!searchList.contains(txt)) {
        searchList.add(txt);
        //保存搜索记录
        await SharedPreferencesTool.saveStringList(searchHistory, searchList);
      }
      //设置 search
      search = txt;
    } else {
      search = null;
    }

    //开始搜索,要求刷新
    refreshController.requestRefresh(needMove: false);
  }

  void doRefresh() {
    page = 1;
    String? sort;
    if (sortModel.sortType == SortType.price) {
      sort = "price_-1";
    } else if (sortModel.sortType == SortType.sold) {
      sort = "salecount_-1";
    }
    _getGenericProducts(sort: sort, isRefresh: true);
  }

  void doLoadMore() {
    page++;
    String? sort;
    if (sortModel.sortType == SortType.price) {
      sort = "price_-1";
    } else if (sortModel.sortType == SortType.sold) {
      sort = "salecount_-1";
    }
    _getGenericProducts(sort: sort, isRefresh: false);
  }

  void _getGenericProducts({String? sort, required bool isRefresh}) async {
    Map<String, dynamic> queryParameters = {};
    queryParameters["page"] = page;
    queryParameters["pageSize"] = pageSize;

    if (cid != null) {
      queryParameters["cid"] = cid;
    }

    if (search != null) {
      queryParameters["search"] = search;
    }

    if (sort != null) {
      queryParameters["sort"] = sort;
    }

    try {
      //获取结果
      Products products =
          await RestApi.getProducts(queryParameters: queryParameters);
      if (isRefresh) {
        sortProducts.clear();
        if (products.result != null) {
          sortProducts.addAll(products.result!);
        }
        //刷新成功，并重置底部显示条
        refreshController.refreshCompleted(resetFooterState: true);
      } else {
        if (products.result != null) {
          if (products.result!.isNotEmpty) {
            sortProducts.addAll(products.result!);
            //加载更多成功
            refreshController.loadComplete();
          } else {
            //加载无数据
            refreshController.loadNoData();
          }
        }
      }
    } on MyNetError catch (e) {
      if (!isRefresh) {
        page--;
        //加载更多失败
        refreshController.loadFailed();
      } else {
        //刷新失败
        refreshController.refreshFailed();
      }
      // ignore: avoid_print
      print("MyNetError ${e.code} ${e.message} ${e.data}");
      Fluttertoast.showToast(msg: e.message, toastLength: Toast.LENGTH_LONG);
    } catch (e) {
      if (!isRefresh) {
        page--;
        //加载更多失败
        refreshController.loadFailed();
      } else {
        //刷新失败
        refreshController.refreshFailed();
      }
      // ignore: avoid_print
      print(e);
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    }
  }

  void goDetail(String id) {
    Get.toNamed(PRODUCT_DETAIL_PATH, parameters: {"id": id});
  }

  @override
  void onClose() {
    //需要销毁
    tabController.dispose();
    super.onClose();
  }
}
