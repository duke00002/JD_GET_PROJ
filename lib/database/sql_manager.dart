//数据库类
import 'dart:convert';

import 'package:jd_get_proj/data_tool/shared_preferences_tool.dart';
import 'package:jd_get_proj/models/user_login_model.dart';
import 'package:sqflite/sqflite.dart';

class SqlManager {
  //数据库版本
  // ignore: constant_identifier_names
  static const int _VERSION = 1;

  //数据库名称
  // ignore: constant_identifier_names
  // static const String _DB_NAME = "root.db";

  //数据库对象
  static Database? _database;

  //动态生成数据库名字（遵循用户ID生成）
  static Future<String> _getDbName() async {
    var userString = await SharedPreferencesTool.getString("user");
    Userinfo userinfo = Userinfo.fromJson(json.decode(userString!));
    return "${userinfo.sId}.db";
  }

  //初始化数据库对象
  static Future<Database> _init(String dbPath) async {
    //初始化并生成数据库对象
    return openDatabase(
      dbPath,
      version: _VERSION,
      onCreate: (db, version) {
        // ignore: avoid_print
        print("onCreate $version");
      },
      onUpgrade: (db, oldVersion, newVersion) {
        // ignore: avoid_print
        print("onUpgrade $newVersion");
      },
    );
  }

  //获取数据库对象--》单态（含自动生成）
  static Future<Database> getDatabase() async {
    //获取数据库名字
    String dbName = await _getDbName();
    //生成数据库存储位置
    String dbPath = await getDatabasesPath() + "/$dbName";
    //数据库为空，生成新的
    if (_database == null) {
      _database = await _init(dbPath);
      print("新数据库位置：$dbPath");
    } else {
      //如果用户进行切换，则生成新的DB
      if (_database!.path != dbPath) {
        _database = await _init(dbPath);
        print("切换数据库位置：$dbPath");
      }
    }
    //返回DB对象
    return _database!;
  }

  //判断表是否存在
  static Future<bool> isTableExists(String tableName) async {
    Database database = await getDatabase();
    //查询语句,是否存在表
    String queryString =
        "select * from sqlite_master where type='table' and name='$tableName'";
    //查询结果
    var result = await database.rawQuery(queryString);
    //判断结果是否为空
    return result.isNotEmpty;
  }

  //关闭数据库
  static void close() {
    _database?.close();
    _database = null;
  }
}
