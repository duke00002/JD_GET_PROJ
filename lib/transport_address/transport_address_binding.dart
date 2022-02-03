import 'package:get/get.dart';
import 'package:jd_get_proj/transport_address/transport_address_controller.dart';

class TransportAddressBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TransportAddressController());
  }
}
