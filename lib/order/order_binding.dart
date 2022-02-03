import 'package:get/get.dart';
import 'package:jd_get_proj/order/order_controller.dart';

class OrderBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderController());
  }
}
