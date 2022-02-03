import 'package:jd_get_proj/database/providers/cart_table_provider.dart';

class CartItemModel {
  //表列名
  int? id;
  //商品ID
  String? productId;
  //商品图片
  String? image;
  //商品名称
  String? title;
  //商品属性
  String? attrs;
  //商品单价
  int? price;
  //购买个数
  int? count;
  //创建时间
  int? time;
  //是否选中
  bool checked = false;

  CartItemModel(this.id, this.productId, this.image, this.title, this.attrs,
      this.price, this.count, this.time);

  CartItemModel.fromJson(Map<String, dynamic> json) {
    id = json[CartTableProvider.columnId];
    productId = json[CartTableProvider.columnProductId];
    image = json[CartTableProvider.columnImage];
    title = json[CartTableProvider.columnTitle];
    attrs = json[CartTableProvider.columnAttrs];
    price = json[CartTableProvider.columnPrice];
    count = json[CartTableProvider.columnCount];
    time = json[CartTableProvider.columnTime];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    //不插入ID
    data[CartTableProvider.columnProductId] = productId;
    data[CartTableProvider.columnImage] = image;
    data[CartTableProvider.columnTitle] = title;
    data[CartTableProvider.columnAttrs] = attrs;
    data[CartTableProvider.columnPrice] = price;
    data[CartTableProvider.columnCount] = count;
    data[CartTableProvider.columnTime] = time;
    return data;
  }
}
