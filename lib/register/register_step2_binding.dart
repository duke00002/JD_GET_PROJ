import 'package:get/get.dart';
import 'package:jd_get_proj/register/register_step2_controller.dart';

class RegisterStep2Binding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterStep2Controller());
  }
}
