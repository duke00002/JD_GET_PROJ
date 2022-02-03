import 'package:get/get.dart';
import 'package:jd_get_proj/search/search_controller.dart';

class SearchBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchController());
  }
}
