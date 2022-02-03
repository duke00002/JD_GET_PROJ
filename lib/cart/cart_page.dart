import 'package:flutter/material.dart';
import 'package:jd_get_proj/cart/cart_common.dart';
import 'package:jd_get_proj/cart/cart_controller.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jd_get_proj/models/cart_item_model.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("cart".tr), centerTitle: true, actions: [
          IconButton(
              onPressed: CartController.to.share, icon: const Icon(Icons.share))
        ]),
        body: Container(color: Colors.grey.shade200, child: _getBody()));
  }

  Widget _getBody() {
    return Obx(() {
      return CartController.to.cartItems.isEmpty
          ? getEmptyView()
          : Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(10.w, 10.w, 10.w, 0),
                      child: _getCartItemsView())),
              getSettleView(
                  CartController.to.checkedAll.value,
                  CartController.to.onAllCheckChanged,
                  CartController.to.settle,
                  CartController.to.totalPrice.value)
            ]);
    });
  }

  Widget _getCartItemsView() {
    return ListView.builder(
        itemBuilder: (context, index) {
          CartItemModel cartItemModel = CartController.to.cartItems[index];
          return getSlidableView(cartItemModel, () {
            CartController.to.delete(index);
          }, () {
            CartController.to.onItemTap(index);
          }, (checked) {
            CartController.to.onItemCheckChanged(index, checked);
          }, () {
            CartController.to.onItemMinus(index);
          }, () {
            CartController.to.onItemPlus(index);
          });
        },
        itemCount: CartController.to.cartItems.length);
  }
}
