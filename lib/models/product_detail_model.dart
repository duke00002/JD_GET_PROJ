class ProductDetailModel {
  ProductDetailResult? productDetailResult;

  ProductDetailModel({this.productDetailResult});

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    productDetailResult = json['result'] != null
        ? ProductDetailResult.fromJson(json['result'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (productDetailResult != null) {
      data['result'] = productDetailResult!.toJson();
    }
    return data;
  }
}

class ProductDetailResult {
  String? sId;
  String? title;
  String? cid;
  int? price;
  String? oldPrice;
  String? isBest;
  String? isHot;
  String? isNew;
  List<Attr>? attr;
  String? status;
  String? pic;
  String? content;
  String? cname;
  int? salecount;
  String? subTitle;

  ProductDetailResult(
      {this.sId,
      this.title,
      this.cid,
      this.price,
      this.oldPrice,
      this.isBest,
      this.isHot,
      this.isNew,
      this.attr,
      this.status,
      this.pic,
      this.content,
      this.cname,
      this.salecount,
      this.subTitle});

  ProductDetailResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    cid = json['cid'];
    price = int.parse(json['price'].toString());
    oldPrice = json['old_price'];
    isBest = json['is_best'].toString();
    isHot = json['is_hot'].toString();
    isNew = json['is_new'].toString();
    if (json['attr'] != null) {
      attr = <Attr>[];
      json['attr'].forEach((v) {
        attr!.add(Attr.fromJson(v));
      });
    }
    status = json['status'];
    pic = json['pic'];
    content = json['content'];
    cname = json['cname'];
    salecount = json['salecount'];
    subTitle = json['sub_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['title'] = title;
    data['cid'] = cid;
    data['price'] = price;
    data['old_price'] = oldPrice;
    data['is_best'] = isBest;
    data['is_hot'] = isHot;
    data['is_new'] = isNew;
    if (attr != null) {
      data['attr'] = attr!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['pic'] = pic;
    data['content'] = content;
    data['cname'] = cname;
    data['salecount'] = salecount;
    data['sub_title'] = subTitle;
    return data;
  }
}

class Attr {
  String? cate;
  List<String>? list;

  Attr({this.cate, this.list});

  Attr.fromJson(Map<String, dynamic> json) {
    cate = json['cate'];
    list = json['list'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['cate'] = cate;
    data['list'] = list;
    return data;
  }
}
