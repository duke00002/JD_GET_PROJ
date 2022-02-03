import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jd_get_proj/config/route_configs.dart';
import 'package:jd_get_proj/data_tool/shared_preferences_tool.dart';

class SearchController extends GetxController {
  static SearchController get to => Get.find<SearchController>();
  //输入框控制器
  final TextEditingController controller = TextEditingController();
  //输入框焦点控制
  final FocusNode focusNode = FocusNode();

  static const String searchHistory = "SearchHistory";

  var searchList = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    _getSearchList();
  }

  void _getSearchList() async {
    var list = await SharedPreferencesTool.getStringList(searchHistory);
    if (list != null) {
      searchList.addAll(list);
    }
  }

  void clearSearchList() async {
    await SharedPreferencesTool.delete(searchHistory);
    searchList.clear();
  }

  void searchTapped() {
    onSubmitted(controller.text);
  }

  void onSubmitted(String txt) async {
    //收起键盘，失去焦点
    focusNode.unfocus();
    if (txt.trim() != "") {
      if (!searchList.contains(txt)) {
        searchList.add(txt);
        await SharedPreferencesTool.saveStringList(searchHistory, searchList);
      }
      //跳转到商品列表页 (含参数)
      Get.offAndToNamed(PRODUCTS_PATH, parameters: {"search": txt.trim()});
    } else {
      //跳转到商品列表页（无参数）
      Get.offAndToNamed(PRODUCTS_PATH);
    }
  }

  @override
  void onClose() {
    //销毁
    focusNode.dispose();
    //销毁
    controller.dispose();
    super.onClose();
  }
}
