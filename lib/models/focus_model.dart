class FocusModel {
  List<FocusResult>? result;

  FocusModel({this.result});

  FocusModel.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = <FocusResult>[];
      json['result'].forEach((v) {
        result!.add(FocusResult.fromJson(v));
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

class FocusResult {
  String? sId;
  String? title;
  String? status;
  String? pic;
  String? url;

  FocusResult({this.sId, this.title, this.status, this.pic, this.url});

  FocusResult.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    status = json['status'];
    pic = json['pic'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['title'] = title;
    data['status'] = status;
    data['pic'] = pic;
    data['url'] = url;
    return data;
  }
}
