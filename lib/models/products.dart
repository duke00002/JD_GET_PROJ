class Products {
  List<ProductResult>? result;

  Products({this.result});

  Products.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <ProductResult>[];
      json['result'].forEach((v) {
        result!.add(ProductResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductResult {
  String? sId;
  String? title;
  String? cid;
  int? price;
  String? oldPrice;
  String? pic;
  String? sPic;

  ProductResult(
      {this.sId,
      this.title,
      this.cid,
      this.price,
      this.oldPrice,
      this.pic,
      this.sPic});

  ProductResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    cid = json['cid'];
    price = int.parse(json['price'].toString());
    oldPrice = json['old_price'].toString();
    pic = json['pic'];
    sPic = json['s_pic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['title'] = title;
    data['cid'] = cid;
    data['price'] = price;
    data['old_price'] = oldPrice;
    data['pic'] = pic;
    data['s_pic'] = sPic;
    return data;
  }
}
