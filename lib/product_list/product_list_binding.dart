import 'package:get/get.dart';
import 'package:jd_get_proj/product_list/product_list_controller.dart';

class ProductListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductListController());
  }
}
