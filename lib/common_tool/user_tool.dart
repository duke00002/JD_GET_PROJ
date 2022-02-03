import 'dart:convert';

import 'package:jd_get_proj/data_tool/shared_preferences_tool.dart';
import 'package:jd_get_proj/models/user_login_model.dart';

Future<Userinfo> getUser() async {
  var userString = await SharedPreferencesTool.getString("user");
  Userinfo userinfo = Userinfo.fromJson(json.decode(userString!));
  return userinfo;
}
