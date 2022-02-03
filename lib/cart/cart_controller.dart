import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jd_get_proj/config/route_configs.dart';
import 'package:jd_get_proj/data_tool/shared_preferences_tool.dart';
import 'package:jd_get_proj/database/providers/cart_table_provider.dart';
import 'package:jd_get_proj/models/cart_item_model.dart';

class CartController extends GetxController {
  static CartController get to => Get.find<CartController>();
  //购物车，表控制器
  final CartTableProvider _cartTableProvider = CartTableProvider();
  //购物车列表项
  var cartItems = <CartItemModel>[].obs;
  //全选状态
  var checkedAll = false.obs;
  //总价（已勾选状况下）
  var totalPrice = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  //查询所有
  void queryAll() async {
    //复原状态
    checkedAll.value = false;
    totalPrice.value = 0;
    cartItems.clear();
    //是否登录
    var userString = await SharedPreferencesTool.getString("user");
    //没有登录,提示登录
    if (userString == null) {
      Fluttertoast.showToast(msg: "please_login".tr);
    } else {
      //重新查询
      cartItems.addAll(await _cartTableProvider.queryAll());
    }
  }

  //删除一个商品
  void delete(int index) async {
    //数据库删除
    await _cartTableProvider.delete(cartItems[index].id!);
    //obs删除
    cartItems.removeAt(index);
    //重新计算总价！！！
    _changeTotalPrice();
  }

  //跳转详商品情页
  void onItemTap(index) {
    Get.toNamed(PRODUCT_DETAIL_PATH,
        parameters: {"id": cartItems[index].productId!});
  }

  //单项打勾或反选
  void onItemCheckChanged(int index, bool? check) {
    CartItemModel cartItemModel = cartItems[index];
    cartItemModel.checked = check!;
    //要让 obs 列表改变，才会刷新
    cartItems.removeAt(index);
    cartItems.insert(index, cartItemModel);
    //获得选中的数量
    int checkedCount = 0;
    for (var element in cartItems) {
      if (element.checked) {
        checkedCount++;
      }
    }
    //设置obs的值，判断是不是全选
    checkedAll.value = checkedCount == cartItems.length;
    //重新计算总价！！！
    _changeTotalPrice();
  }

  //增加一个
  void onItemPlus(int index) {
    CartItemModel cartItemModel = cartItems[index];
    cartItemModel.count = cartItemModel.count! + 1;
    // //要让 obs 列表改变，才会刷新
    cartItems.removeAt(index);
    cartItems.insert(index, cartItemModel);
    //重新计算总价！！！
    _changeTotalPrice();
    //更新数据库个数
    _cartTableProvider.update(cartItemModel);
  }

  //减少一个
  void onItemMinus(int index) {
    CartItemModel cartItemModel = cartItems[index];
    cartItemModel.count = cartItemModel.count! - 1;
    if (cartItemModel.count! == 0) {
      cartItemModel.count = 1;
    }
    // //要让 obs 列表改变，才会刷新
    cartItems.removeAt(index);
    cartItems.insert(index, cartItemModel);
    //重新计算总价！！！
    _changeTotalPrice();
    //更新数据库个数
    _cartTableProvider.update(cartItemModel);
  }

  //所有都选中
  void onAllCheckChanged(bool? check) {
    checkedAll.value = check!;
    for (var element in cartItems) {
      element.checked = check;
    }
    //重新计算总价！！！
    _changeTotalPrice();
  }

  //每次勾选或删除情况都重新计算总价！！！
  void _changeTotalPrice() {
    int sum = 0;
    for (var element in cartItems) {
      if (element.checked) {
        sum += element.price! * element.count!;
      }
    }
    totalPrice.value = sum;
  }

  void settle() {
    if (totalPrice.value == 0) {
      Fluttertoast.showToast(msg: "choose_product_notice".tr);
      return;
    }
    //选出打勾的
    List<CartItemModel> dataList = [];
    for (var element in cartItems) {
      if (element.checked) {
        dataList.add(element);
      }
    }
    //传商品列表到订单页
    Get.toNamed(ORDER_PATH, arguments: dataList);
  }

  @override
  void onClose() {
    super.onClose();
  }

  void share() {}
}
