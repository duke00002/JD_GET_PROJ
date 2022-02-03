class PinCodeModel {
  bool? success;
  String? code;
  String? message;

  PinCodeModel({this.success, this.code, this.message});

  PinCodeModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['success'] = success;
    data['code'] = code;
    data['message'] = message;
    return data;
  }
}
