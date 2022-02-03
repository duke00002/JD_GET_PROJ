import 'package:flutter/material.dart';
import 'package:jd_get_proj/transport_address/transport_address_controller.dart';
import 'package:jd_get_proj/transport_address/transport_common.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddTransportAddressPage extends StatelessWidget {
  const AddTransportAddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(TransportAddressController.to.title.tr),
            centerTitle: true),
        body: Column(children: [
          Expanded(child: _getItems()),
          getAddressBottom(TransportAddressController.to.btnTitle,
              TransportAddressController.to.onBtnTap)
        ]));
  }

  Widget _getItems() {
    List<Widget> items = [];
    //姓名
    items.add(getTextFieldLine(
        null,
        "recipient_name".tr,
        1,
        TextInputType.text,
        TransportAddressController.to.nameTxtcontroller,
        TransportAddressController.to.nameFocusNode));
    //电话
    items.add(getTextFieldLine(
        null,
        "recipient_phone".tr,
        1,
        TextInputType.phone,
        TransportAddressController.to.phoneTxtcontroller,
        TransportAddressController.to.phoneFocusNode));
    //省市区
    items.add(Obx(() {
      return getAddressTextFieldLine(
          null,
          "province_city_district".tr,
          1,
          TextEditingController(
              text: TransportAddressController.to.provinceCityDistrict.value),
          TransportAddressController.to.provinceCityDistrictTap);
    }));
    //地址
    items.add(getTextFieldLine(
        120.h,
        "recipient_address".tr,
        4,
        TextInputType.text,
        TransportAddressController.to.addressTxtcontroller,
        TransportAddressController.to.addressFocusNode));

    //是否默认，观察改变，Obx
    items.add(Obx(() {
      return getIsDefalutLine(
          null,
          TransportAddressController.to.isDefault.value,
          TransportAddressController.to.onDefaultChanged);
    }));

    return ListView(children: items);
  }
}
