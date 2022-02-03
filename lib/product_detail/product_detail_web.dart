import 'package:flutter/material.dart';
//读取html的插件
import 'package:flutter_html/flutter_html.dart';
import 'package:jd_get_proj/product_detail/product_detail_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductDetailWeb extends StatelessWidget {
  const ProductDetailWeb({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? content = ProductDetailController
        .to.detailModel.value.productDetailResult!.content;
    if (content == null) {
      return Container(color: Colors.white);
    }

    return SingleChildScrollView(
        padding: EdgeInsets.all(10.w),
        //读取html的插件
        child: Html(
            //html内容
            data: content,
            //点击链接
            onLinkTap: (url, context, attributes, element) {
              ProductDetailController.to.openUrl(url ?? "");
            },
            //点击图片
            onImageTap: (url, context, attributes, element) {
              ProductDetailController.to.openImage(url ?? "");
            }));
  }
}
