import 'dart:async';

import 'package:get/get.dart';
import 'package:jd_get_proj/config/route_configs.dart';

class InitController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 1), () {
      Get.offAndToNamed(HOME_ALL_PATH);
    });
  }

  @override
  void onReady() {
    super.onReady();
  }
}
