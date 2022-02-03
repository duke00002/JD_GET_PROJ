import 'package:get/get.dart';
import 'package:jd_get_proj/product_detail/product_detail_controller.dart';

class ProductDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductDetailController());
  }
}
