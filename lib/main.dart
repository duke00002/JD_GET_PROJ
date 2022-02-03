import 'package:flutter/material.dart';
import 'package:jd_get_proj/my_app.dart';

void main() {
  //数据库新建之前，必须要有这句话！！！：确保有一个 WidgetsBinding 的实例
  //WidgetsFlutterBinding.ensureInitialized();
  //生成表
  //_createTables();
  //进入主程序
  runApp(createMyApp());
}
