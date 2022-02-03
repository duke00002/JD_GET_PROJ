import 'package:get/get.dart';
import 'package:jd_get_proj/login_register/login_register_controller.dart';

class LoginRegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginRegisterController());
  }
}
