import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ScanTool {
  //启动扫码
  static Future<ScanResult> openScanner() async {
    //扫码结果
    ScanResult result;
    try {
      //开始扫码
      result = await BarcodeScanner.scan(
          options: ScanOptions(autoEnableFlash: false, strings: {
        //国际化翻译
        'cancel': "cancel".tr,
        'flash_on': 'flash_on'.tr,
        'flash_off': 'flash_off'.tr
      }));
    } on PlatformException catch (e) {
      result = ScanResult(
          type: ResultType.Error,
          format: BarcodeFormat.unknown,
          rawContent: e.code == BarcodeScanner.cameraAccessDenied
              //国际化翻译
              ? 'no authorize camera'.tr
              : '${"unknown error".tr}: $e');
    }
    //result.rawContent：扫码内容
    return result;
  }
}
