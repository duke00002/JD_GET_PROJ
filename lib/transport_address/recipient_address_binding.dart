import 'package:get/get.dart';
import 'package:jd_get_proj/transport_address/recipient_address_controller.dart';

class RecipientAddressBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RecipientAddressController());
  }
}
