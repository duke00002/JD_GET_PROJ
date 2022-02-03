import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jd_get_proj/models/product_detail_model.dart';
import 'package:jd_get_proj/product_detail/line_widget.dart';
import 'package:jd_get_proj/product_detail/product_common.dart';
import 'package:jd_get_proj/product_detail/product_detail_controller.dart';
import 'package:jd_get_proj/rest_tools/rest_api.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ProductDetailInfo extends StatelessWidget {
  const ProductDetailInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      _getImage(),
      _getTitle(),
      _getSubTitle(),
      _getPrice(),
      _getAttr(),
      getLineWidget("deliver_title".tr, "deliver_free".tr)
    ]);
  }

  Widget _getImage() {
    String urlPath =
        ProductDetailController.to.detailModel.value.productDetailResult!.pic ??
            "";
    String url = "${RestApi.host}/${urlPath.replaceAll("\\", "/")}";
    return InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: () {
          ProductDetailController.to.openImage(url);
        },
        child: AspectRatio(
            aspectRatio: 16.0 / 9.0,
            child: CachedNetworkImage(imageUrl: url, fit: BoxFit.contain)));
  }

  Widget _getTitle() {
    String title = ProductDetailController
            .to.detailModel.value.productDetailResult!.title ??
        "no_data".tr;

    return getGenricTitle(title, Colors.black87, 16.sp);
  }

  Widget _getSubTitle() {
    String title = ProductDetailController
            .to.detailModel.value.productDetailResult!.subTitle ??
        "no_data".tr;

    return getGenricTitle(title, Colors.grey, 14.sp);
  }

  Widget _getPrice() {
    ProductDetailResult result =
        ProductDetailController.to.detailModel.value.productDetailResult!;
    return getPrice(result.price, result.oldPrice);
  }

  //当前选中的属性行
  Widget _getAttr() {
    return Obx(() {
      return ProductDetailController.to.selectedAttr.isEmpty
          ? const SizedBox(height: 0)
          : _getAttrWidget();
    });
  }

  //当前选中的属性行
  Widget _getAttrWidget() {
    String displayAttr =
        ProductDetailController.to.selectedAttr.values.join("，");
    return InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onTap: attrOnTap,
        child: getLineWidget("selected_attr".tr,
            "$displayAttr，X ${ProductDetailController.to.count}"));
  }

  //点击属性行
  void attrOnTap() async {
    var result = await Get.bottomSheet(
        Container(
            height: 300.h,
            padding: EdgeInsets.fromLTRB(10.w, 20.w, 10.w, 20.w),
            //这边需要观察，暂时选中的需要改变颜色
            child: Obx(() {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _getBottomSheetContent());
            })),
        backgroundColor: Colors.white);

    //证明是点击了空白处收起
    if (result == null) {
      //取消属性选定
      ProductDetailController.to.cancelAttrNoClose();
    }
  }

  //底部弹出属性菜单
  List<Widget> _getBottomSheetContent() {
    //获取商品属性列表
    var attrlist =
        ProductDetailController.to.detailModel.value.productDetailResult!.attr!;
    //属性行（多行）
    var attrRows = attrlist.map((e) {
      //获得属性行
      return getAttrRow(e, ProductDetailController.to.getAttrColor,
          ProductDetailController.to.setTempSelectedAttr);
    }).toList();
    //按钮组件
    var btnView = getSheetBtn(
        "confirm".tr,
        "cancel".tr,
        Colors.green,
        Colors.grey,
        ProductDetailController.to.confirmAttr,
        ProductDetailController.to.cancelAttr);

    //返回组件列表
    List<Widget> views = [];
    views.addAll(attrRows);
    views.add(btnView);
    return views;
  }
}
