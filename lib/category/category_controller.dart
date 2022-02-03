import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jd_get_proj/common_tool/scan_tool.dart';
import 'package:jd_get_proj/config/route_configs.dart';
import 'package:jd_get_proj/models/category_model.dart';
import 'package:jd_get_proj/rest_tools/my_net_error.dart';
import 'package:jd_get_proj/rest_tools/rest_api.dart';

class CategoryController extends GetxController {
  static CategoryController get to => Get.find<CategoryController>();

  var messageCount = 8.obs;

  var selectedIndex = 0.obs;

  var categories = <CategoryResult>[].obs;

  var subCategories = <CategoryResult>[].obs;

  void openScanner() async {
    ScanResult result = await ScanTool.openScanner();
    //result.rawContent：扫码内容
    Fluttertoast.showToast(
        msg: result.rawContent, toastLength: Toast.LENGTH_LONG);
  }

  void goSearchPage() {
    Get.toNamed(SEARCH_PATH);
  }

  void goMessagePage() {
    print("go mesage");
  }

  void leftCategoryTapped(int index) {
    selectedIndex.value = index;
    //获取子菜单
    _getSubCategories();
  }

  void goProductList(int index) {
    Map<String, String> parameters = {"cid": subCategories[index].sId!};
    Get.toNamed(PRODUCTS_PATH, parameters: parameters);
  }

  @override
  void onInit() {
    super.onInit();
    //获取分类列表
    _getCategories();
  }

  void _getCategories() async {
    try {
      //获取结果
      CategoryModel categoryModels = await RestApi.getCategories();
      //清空老列表
      categories.clear();
      //重置默认Index
      selectedIndex.value = 0;

      if (categoryModels.result != null) {
        categories.addAll(categoryModels.result!);
      }
      //获取子菜单显示
      _getSubCategories();
    } on MyNetError catch (e) {
      // ignore: avoid_print
      print("MyNetError ${e.code} ${e.message} ${e.data}");
      Fluttertoast.showToast(msg: e.message, toastLength: Toast.LENGTH_LONG);
    } catch (e) {
      // ignore: avoid_print
      print(e);
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    }
  }

  void _getSubCategories() async {
    try {
      Map<String, dynamic> queryParameters = {};
      queryParameters["pid"] = categories[selectedIndex.value].sId;

      //获取结果
      CategoryModel categoryModels =
          await RestApi.getCategories(queryParameters: queryParameters);
      //清空老列表
      subCategories.clear();

      if (categoryModels.result != null) {
        subCategories.addAll(categoryModels.result!);
      }
    } on MyNetError catch (e) {
      // ignore: avoid_print
      print("MyNetError ${e.code} ${e.message} ${e.data}");
      Fluttertoast.showToast(msg: e.message, toastLength: Toast.LENGTH_LONG);
    } catch (e) {
      // ignore: avoid_print
      print(e);
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
