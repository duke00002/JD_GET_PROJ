import 'package:get/get.dart';
import 'package:jd_get_proj/register/register_step3_controller.dart';

class RegisterStep3Binding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RegisterStep3Controller());
  }
}
