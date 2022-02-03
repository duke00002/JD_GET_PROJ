import 'package:get/get.dart';
import 'package:jd_get_proj/init/init_controller.dart';

class InitBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(InitController());
    //lazyPut 只有获取对象实例的时候才会调用 onInit 方法
    // Get.lazyPut(() => InitController());
  }
}
