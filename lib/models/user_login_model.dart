class UserLoginModel {
  bool? success;
  String? message;
  List<Userinfo>? userinfo;

  UserLoginModel({this.success, this.message, this.userinfo});

  UserLoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['userinfo'] != null) {
      userinfo = <Userinfo>[];
      json['userinfo'].forEach((v) {
        userinfo!.add(Userinfo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    data['message'] = message;
    if (userinfo != null) {
      data['userinfo'] = userinfo!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Userinfo {
  String? sId;
  String? username;
  String? tel;
  String? salt;

  Userinfo({this.sId, this.username, this.tel, this.salt});

  Userinfo.init();

  Userinfo.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    username = json['username'];
    tel = json['tel'];
    salt = json['salt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['_id'] = sId;
    data['username'] = username;
    data['tel'] = tel;
    data['salt'] = salt;
    return data;
  }
}
