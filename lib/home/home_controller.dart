import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jd_get_proj/common_tool/scan_tool.dart';
import 'package:jd_get_proj/config/route_configs.dart';
import 'package:jd_get_proj/models/focus_model.dart';
import 'package:jd_get_proj/models/products.dart';
import 'package:jd_get_proj/rest_tools/my_net_error.dart';
import 'package:jd_get_proj/rest_tools/rest_api.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find<HomeController>();

  var messageCount = 8.obs;
  //广告页列表
  RxList<FocusResult> focuses = <FocusResult>[].obs;
  //热门商品列表
  RxList<ProductResult> hots = <ProductResult>[].obs;
  //精华商品列表
  RxList<ProductResult> bests = <ProductResult>[].obs;
  //新品商品列表
  RxList<ProductResult> news = <ProductResult>[].obs;

  void openScanner() async {
    ScanResult result = await ScanTool.openScanner();
    //result.rawContent：扫码内容
    Fluttertoast.showToast(
        msg: result.rawContent, toastLength: Toast.LENGTH_LONG);
  }

  void goFocus(int index) {
    Get.toNamed(PRODUCT_DETAIL_PATH, parameters: {"id": focuses[index].sId!});
  }

  void goSearchPage() {
    Get.toNamed(SEARCH_PATH);
  }

  void goMessagePage() {
    print("go mesage");
  }

  void goProductDetail(ProductResult productResult) {
    Get.toNamed(PRODUCT_DETAIL_PATH, parameters: {"id": productResult.sId!});
  }

  @override
  void onInit() {
    super.onInit();
    _getFocus();
    getGenericProducts(isHot: 1);
    getGenericProducts(isBest: 1);
  }

  void _getFocus() async {
    try {
      //获取结果
      FocusModel focusModel = await RestApi.getFocus();
      focuses.clear();
      if (focusModel.result != null) {
        focuses.addAll(focusModel.result!);
      }
    } on MyNetError catch (e) {
      // ignore: avoid_print
      print("MyNetError ${e.code} ${e.message} ${e.data}");
      Fluttertoast.showToast(msg: e.message);
    } catch (e) {
      // ignore: avoid_print
      print(e);
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  void getGenericProducts(
      {int? page,
      int? pageSize,
      String? cid,
      String? search,
      int? isBest,
      int? isHot,
      int? isNew}) async {
    Map<String, dynamic> queryParameters = {};
    if (page != null) {
      queryParameters["page"] = page;
    }

    if (pageSize != null) {
      queryParameters["pageSize"] = pageSize;
    }

    if (cid != null) {
      queryParameters["cid"] = cid;
    }

    if (search != null) {
      queryParameters["search"] = search;
    }

    if (isBest != null) {
      queryParameters["is_best"] = isBest;
    }

    if (isHot != null) {
      queryParameters["is_hot"] = isHot;
    }
    if (isNew != null) {
      queryParameters["is_new"] = isNew;
    }

    try {
      //获取结果
      Products products =
          await RestApi.getProducts(queryParameters: queryParameters);
      if (isHot != null) {
        hots.clear();
        if (products.result != null) {
          hots.addAll(products.result!);
        }
      } else if (isBest != null) {
        bests.clear();
        if (products.result != null) {
          bests.addAll(products.result!);
        }
      } else if (isNew != null) {
        news.clear();
        if (products.result != null) {
          news.addAll(products.result!);
        }
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
