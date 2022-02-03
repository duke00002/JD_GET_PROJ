import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jd_get_proj/transport_address/recipient_address_controller.dart';
import 'package:jd_get_proj/transport_address/transport_common.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RecipientAddressPage extends StatelessWidget {
  const RecipientAddressPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Text("recipient_address_list".tr), centerTitle: true),
        body: Column(children: [
          Expanded(child: _getView()),
          getAddressBottom(
              "add_address".tr, RecipientAddressController.to.onBtnTap)
        ]));
  }

  Widget _getView() {
    return Obx(() {
      return RecipientAddressController.to.addresses.isEmpty
          ? Center(
              child: Text("no_data".tr,
                  style: TextStyle(color: Colors.black87, fontSize: 30.sp)))
          : getAddressListView(
              RecipientAddressController.to.addresses,
              RecipientAddressController.to.onItemEdit,
              RecipientAddressController.to.onItemDelete);
    });
  }
}
