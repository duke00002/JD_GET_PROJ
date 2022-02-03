import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:jd_get_proj/common_tool/phone_tool.dart';
import 'package:jd_get_proj/database/providers/transport_table_provider.dart';
import 'package:jd_get_proj/models/transport_item_model.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jd_get_proj/transport_address/transport_common.dart';

class TransportAddressController extends GetxController {
  static TransportAddressController get to =>
      Get.find<TransportAddressController>();

  //地址表控制器
  final TransportTableProvider _transportTableProvider =
      TransportTableProvider();

  late String title;
  late String btnTitle;

  late TextEditingController nameTxtcontroller;
  late FocusNode nameFocusNode;

  late TextEditingController phoneTxtcontroller;
  late FocusNode phoneFocusNode;

  late TextEditingController addressTxtcontroller;
  late FocusNode addressFocusNode;

  //省市区属性
  var provinceCityDistrict = "".obs;

  //地址变量
  late TransportItemModel _transportItemModel;
  //默认地址选中
  var isDefault = false.obs;

  @override
  void onInit() {
    super.onInit();
    //添加
    if (Get.arguments == null) {
      title = "add_address".tr;
      btnTitle = "add".tr;
      //属性为空的对象
      _transportItemModel = TransportItemModel.init();
    } else {
      title = "update_address".tr;
      btnTitle = "update".tr;
      //编辑
      _transportItemModel = Get.arguments as TransportItemModel;
      //默认地址选中的值
      isDefault.value = _transportItemModel.isDefault!;
    }
    //控件初始化
    _initControllerNode();
  }

  void _initControllerNode() {
    nameTxtcontroller = TextEditingController(text: _transportItemModel.name);
    nameFocusNode = FocusNode();

    phoneTxtcontroller = TextEditingController(text: _transportItemModel.phone);
    phoneFocusNode = FocusNode();

    addressTxtcontroller =
        TextEditingController(text: _transportItemModel.address);
    addressFocusNode = FocusNode();

    if (_transportItemModel.province != null) {
      provinceCityDistrict.value =
          "${_transportItemModel.province}/${_transportItemModel.city}/${_transportItemModel.district}";
    }
  }

  //获取区code
  String _getLocCode(String district) {
    String code = "310000";
    CityPickers.metaCities.forEach((key, value) {
      var map1 = value as Map<String, dynamic>;
      map1.forEach((key, value) {
        if (value["name"] == district) {
          code = key;
        }
      });
    });

    return code;
  }

  //显示省市区选择（含默认选中，locCode）
  void provinceCityDistrictTap() {
    var text = provinceCityDistrict.value;
    String locCode;
    if (text == "") {
      locCode = _getLocCode("杨浦区");
    } else {
      //省市区，data[2]是区
      var data = text.split("/");
      locCode = _getLocCode(data[2]);
    }

    _showCityPickers(locCode);
  }

  //显示省市区选择
  void _showCityPickers(String locCode) async {
    var result = await CityPickers.showCityPicker(
        context: Get.context!, locationCode: locCode, height: 300.h);
    if (result != null) {
      //更新：省市区属性,obs
      provinceCityDistrict.value =
          "${result.provinceName}/${result.cityName}/${result.areaName}";
    }
  }

  void onDefaultChanged(bool? checked) {
    //改变默认状态
    isDefault.value = checked!;
  }

  void onBtnTap() async {
    if (nameTxtcontroller.text == "") {
      Fluttertoast.showToast(msg: "name_is_empty".tr);
      return;
    }

    if (phoneTxtcontroller.text == "") {
      Fluttertoast.showToast(msg: "phone_is_empty".tr);
      return;
    }

    if (!isChinaPhoneLegal(phoneTxtcontroller.text)) {
      Fluttertoast.showToast(msg: "phone_is_not_legal".tr);
      return;
    }

    if (provinceCityDistrict.value == "") {
      Fluttertoast.showToast(msg: "add_your_address".tr);
      return;
    }

    if (addressTxtcontroller.text == "") {
      Fluttertoast.showToast(msg: "add_recipient_address".tr);
      return;
    }
    //姓名
    _transportItemModel.name = nameTxtcontroller.text;
    //电话
    _transportItemModel.phone = phoneTxtcontroller.text;
    //省市区
    var data = provinceCityDistrict.value.split("/");
    _transportItemModel.province = data[0];
    _transportItemModel.city = data[1];
    _transportItemModel.district = data[2];
    //详细地址
    _transportItemModel.address = addressTxtcontroller.text;
    //是否为默认地址
    _transportItemModel.isDefault = isDefault.value;

    //id为空，插入新的
    if (_transportItemModel.id == null) {
      await _transportTableProvider.add(_transportItemModel);
    } else {
      //id不为空，更新
      await _transportTableProvider.update(_transportItemModel);
    }
    //回退需要刷新
    Get.back(result: true);
  }

  void _unfocusNodes() {
    //取消焦点，收起键盘
    nameFocusNode.unfocus();
    phoneFocusNode.unfocus();
    addressFocusNode.unfocus();
  }

  void _disposeAll() {
    //焦点销毁
    nameFocusNode.dispose();
    phoneFocusNode.dispose();
    addressFocusNode.dispose();
    //控制器销毁
    nameTxtcontroller.dispose();
    phoneTxtcontroller.dispose();
    addressTxtcontroller.dispose();
  }

  @override
  void onClose() {
    //取消焦点，收起键盘
    _unfocusNodes();
    //焦点销毁,控制器销毁
    _disposeAll();
    super.onClose();
  }
}
