class CategoryModel {
  List<CategoryResult>? result;

  CategoryModel({this.result});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <CategoryResult>[];
      json['result'].forEach((v) {
        result!.add(CategoryResult.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryResult {
  String? sId;
  String? title;
  String? status;
  String? pic;
  String? pid;
  String? sort;

  CategoryResult(
      {this.sId, this.title, this.status, this.pic, this.pid, this.sort});

  CategoryResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    status = json['status'].toString();
    pic = json['pic'];
    pid = json['pid'];
    sort = json['sort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['title'] = title;
    data['status'] = status;
    data['pic'] = pic;
    data['pid'] = pid;
    data['sort'] = sort;
    return data;
  }
}
