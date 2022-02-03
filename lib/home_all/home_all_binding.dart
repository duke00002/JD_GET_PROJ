import 'package:get/get.dart';
import 'package:jd_get_proj/cart/cart_controller.dart';
import 'package:jd_get_proj/category/category_controller.dart';
import 'package:jd_get_proj/home/home_controller.dart';
import 'package:jd_get_proj/home_all/home_all_controller.dart';
import 'package:jd_get_proj/mine/mine_controller.dart';

class HomeAllBinding implements Bindings {
  @override
  void dependencies() {
    //lazyPut 只有获取对象实例的时候才会调用 onInit 方法
    Get.lazyPut<HomeAllController>(() => HomeAllController());
    //可以多个懒绑定
    Get.lazyPut<HomeController>(() => HomeController());
    //绑定分类控制器
    Get.lazyPut<CategoryController>(() => CategoryController());
    //绑定购物车控制器
    Get.put(CartController());
    //不用lazyPut：预先调用一次CartController：onInit
    //之后跳转购物车就直接调用：CartController的queryAll方法
    // Get.lazyPut<CartController>(() => CartController());
    Get.lazyPut(() => MineController());
  }
}
