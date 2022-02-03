import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jd_get_proj/common_tool/get_sortmodels.dart';
import 'package:jd_get_proj/config/route_configs.dart';
import 'package:jd_get_proj/data_tool/shared_preferences_tool.dart';
import 'package:jd_get_proj/database/providers/cart_table_provider.dart';
import 'package:jd_get_proj/events/event_bus.dart';
import 'package:jd_get_proj/models/cart_item_model.dart';
import 'package:jd_get_proj/models/product_detail_model.dart';
import 'package:jd_get_proj/rest_tools/my_net_error.dart';
import 'package:jd_get_proj/rest_tools/rest_api.dart';
//链接打开插件
import 'package:url_launcher/url_launcher.dart';

class ProductDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  static ProductDetailController get to => Get.find<ProductDetailController>();

  var detailModel = ProductDetailModel().obs;
  //选择的参数
  var selectedAttr = {}.obs;
  //暂选的参数
  var tempSelectedAttr = {}.obs;
  //购买数量
  var count = 1.obs;

//Tab控制器
  late TabController tabController;

  PageController pageController = PageController();

  //购物车,表控制器
  final CartTableProvider _cartTableProvider = CartTableProvider();

  //筛选项
  var sortList = getSortDetailList();

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: sortList.length, vsync: this);
    String id = Get.parameters["id"]!;
    print(id);
    _getProductDetail(id);
  }

  void _getProductDetail(String id) async {
    try {
      //获取结果
      var tempDetailModel =
          await RestApi.getProductDetail(queryParameters: {"id": id});
      //obs 更新结果！！！----》通知 obx
      detailModel(tempDetailModel);
      //生成默认的attrs
      _makeDefaultAttr(tempDetailModel.productDetailResult!.attr);
    } on MyNetError catch (e) {
      // ignore: avoid_print
      print("MyNetError ${e.code} ${e.message} ${e.data}");
      Fluttertoast.showToast(msg: e.message, toastLength: Toast.LENGTH_LONG);
    } catch (e) {
      // ignore: avoid_print
      print(e);
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    }
  }

  void _makeDefaultAttr(List<Attr>? attr) {
    if (attr != null && attr.isNotEmpty) {
      selectedAttr.clear();
      //复制暂时选中的
      tempSelectedAttr.clear();

      for (var element in attr) {
        String cate = element.cate!;
        String value = element.list![0];
        selectedAttr[cate] = value;
        //复制暂时选中的
        tempSelectedAttr[cate] = value;
      }
    }
  }

  List<Color> getAttrColor(String attr) {
    if (tempSelectedAttr.containsValue(attr)) {
      return [Colors.red, Colors.white];
    }

    return [Colors.grey.shade200, Colors.black87];
  }

  void setTempSelectedAttr(String key, String value) {
    tempSelectedAttr[key] = value;
  }

  //将暂选属性赋值给选定属性
  void confirmAttr() {
    selectedAttr.addAll(tempSelectedAttr);
    //关闭弹窗,告知有处理
    Get.back(result: true);
  }

  //加入购物车，将暂选属性赋值给选定属性
  void addToCart() async {
    //是否登录
    var userString = await SharedPreferencesTool.getString("user");
    //没有登录,提示登录
    if (userString == null) {
      Fluttertoast.showToast(msg: "please_login".tr);
    } else {
      //增加到购物车
      selectedAttr.addAll(tempSelectedAttr);
      //关闭弹窗,告知有处理
      Get.back(result: true);
      //添加商品购物车中
      int addNum = await _addProductToCart();
      // ignore: avoid_print
      print(addNum);
      Fluttertoast.showToast(msg: "added_to_cart".tr);
    }
  }

  //加入到购物车
  Future<int> _addProductToCart() async {
    var productResult = detailModel.value.productDetailResult!;
    String productId = productResult.sId!;
    String image = productResult.pic!;
    String title = productResult.title!;
    String attrs = selectedAttr.values.join("，");
    int price = productResult.price!;
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    //生成购物车对象
    CartItemModel cartItemModel = CartItemModel(
        null, productId, image, title, attrs, price, count.value, currentTime);

    return await _cartTableProvider.add(cartItemModel);
  }

//将暂选属性赋值给选定属性,跳转结算页面
  void buyNowAndClose() {
    selectedAttr.addAll(tempSelectedAttr);
    //关闭弹窗,告知有处理,跳转结算页面
    Get.back(result: true);
    // Get.offAndToNamed(page, result: true);
  }

  void buyNow() {
    //跳转结算页面
    print("buyNow");
  }

  void toCart() {
    //发送事件广播，跳转购物车
    eventBus.fire(JumpToTabEvent(2));
    //弹出页面直到首页---》Get.until 很重要！！！
    Get.until((route) => Get.currentRoute == HOME_ALL_PATH);
  }

  //取消暂选属性，还原和选定属性一样
  void cancelAttr() {
    tempSelectedAttr.addAll(selectedAttr);
    //关闭弹窗,告知有处理
    Get.back(result: true);
  }

  //取消暂选属性，还原和选定属性一样
  void cancelAttrNoClose() {
    tempSelectedAttr.addAll(selectedAttr);
  }

  //取消暂选属性和购买数量，还原和选定属性一样
  void cancelAttrAndCountNoClose() {
    tempSelectedAttr.addAll(selectedAttr);
    count.value = 1;
  }

  void onMinusTap() {
    if (count.value == 1) {
      return;
    }
    count.value--;
  }

  void onPlusTap() {
    count.value++;
  }

  void tabBarTapped(int index) {
    pageController.jumpToPage(index);
  }

  void onPageChanged(int index) {
    tabController.index = index;
  }

  void openUrl(String url) async {
    //canLaunch 判断是否可以打开
    if (await canLaunch(url)) {
      launch(url);
    } else {
      Fluttertoast.showToast(msg: "无法打开");
    }
  }

  void openImage(String url) {
    Get.toNamed(PHOTO_VIEW_PATH, parameters: {"url": url});
  }

  @override
  void onClose() {
    tabController.dispose();
    pageController.dispose();
    super.onClose();
  }
}
