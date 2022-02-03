import 'package:jd_get_proj/database/sql_manager.dart';
import 'package:sqflite/sqflite.dart';

//表的基类
abstract class BaseTableProvider {
  //抽象方法（表名）
  String getTableName();

  //抽象方法（建表语句）
  String getCreateTableSql();

  //获取DB对象,并生成表
  Future<Database> getDatabase() async {
    //获取DB对象
    Database database = await SqlManager.getDatabase();
    //判断当前表是否存在
    bool isTableExist = await SqlManager.isTableExists(getTableName());
    //如果表不存在，则创建表
    if (!isTableExist) {
      await database.execute(getCreateTableSql());
    }
    return database;
  }

  Future<void> createTable() async {
    //判断当前表是否存在
    bool isTableExist = await SqlManager.isTableExists(getTableName());
    //如果表不存在，则创建表
    if (!isTableExist) {
      //获取DB对象
      Database database = await SqlManager.getDatabase();
      await database.execute(getCreateTableSql());
    }
  }
}
