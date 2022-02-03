import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jd_get_proj/order/order_common.dart';
import 'package:jd_get_proj/order/order_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("order_page_title".tr), centerTitle: true),
        body: Container(
            color: Colors.grey.shade200,
            child: Column(children: [
              _getAddressView(),
              SizedBox(height: 10.w),
              Expanded(child: getOrderListView(OrderController.to.cartItems)),
              getPayBottom(
                  OrderController.to.cartItems, OrderController.to.doOrder)
            ])));
  }

  Widget _getAddressView() {
    return Obx(() {
      return OrderController.to.transportItemModel.value.id == null
          ? getNoAddress(OrderController.to.addAddressTap)
          : getDefaultAddressView(OrderController.to.transportItemModel.value,
              OrderController.to.openAddresses);
    });
  }
}
