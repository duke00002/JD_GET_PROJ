import 'package:jd_get_proj/database/providers/base_table_provider.dart';
import 'package:jd_get_proj/models/transport_item_model.dart';
import 'package:sqflite/sqflite.dart';

//目标表的类
class TransportTableProvider extends BaseTableProvider {
  //表名
  static const String tableName = "transport";
  //表列名
  static const String columnId = "id";
  //名字
  static const String columnName = "name";
  //电话
  static const String columnPhone = "phone";
  //省
  static const String columnProvince = "province";
  //市
  static const String columnCity = "city";
  //区
  static const String columnDistrict = "district";
  //详细地址
  static const String columnAddress = "address";
  //是否为默认
  static const String columnIsDefault = "is_default";

  @override
  String getTableName() {
    return tableName;
  }

  //''' 代表多行字符串
  @override
  String getCreateTableSql() {
    return '''CREATE TABLE $tableName(
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnName TEXT NOT NULL,
      $columnPhone TEXT NOT NULL,
      $columnProvince TEXT NOT NULL,
      $columnCity TEXT NOT NULL,
      $columnDistrict TEXT NOT NULL,
      $columnAddress TEXT NOT NULL,
      $columnIsDefault NUMERIC NOT NULL
    )''';
  }

  //增加地址，查询后决定是新增还是更新
  Future<int> add(TransportItemModel transportItemModel) async {
    //获取db对象
    Database db = await getDatabase();
    //查询是否已经有相同的地址存在语句
    String queryWhere = "$columnPhone =?";
    //查询是否存在
    var result = await db.query(tableName,
        where: queryWhere, whereArgs: [transportItemModel.phone]);
    //不存在
    if (result.isEmpty) {
      return await db.insert(tableName, transportItemModel.toJson());
    } else {
      //更新
      var tempData = result.first;
      //ID where
      String updateWhere = "$columnId =?";
      //更新
      return await db.update(tableName, transportItemModel.toJson(),
          where: updateWhere, whereArgs: [tempData[columnId]]);
    }
  }

  Future<int> update(TransportItemModel transportItemModel) async {
    //获取db对象
    Database db = await getDatabase();
    //ID where
    String updateWhere = "$columnId =?";
    //如果更新为默认地址，需要把其他的都更新为非默认!!!
    if (transportItemModel.isDefault!) {
      await db.update(tableName, {columnIsDefault: 0});
    }
    //更新
    return await db.update(tableName, transportItemModel.toJson(),
        where: updateWhere, whereArgs: [transportItemModel.id!]);
  }

  //按照默认选项降序查询所有
  Future<List<TransportItemModel>> queryAll() async {
    //获取db对象
    Database db = await getDatabase();
    //返回的结果
    var result = await db.query(tableName, orderBy: "$columnIsDefault desc");
    return result.map((e) {
      return TransportItemModel.fromJson(e);
    }).toList();
  }

  Future<int> delete(int id) async {
    //获取db对象
    Database db = await getDatabase();
    //ID where
    String deleteWhere = "$columnId =?";
    //删除
    return await db.delete(tableName, where: deleteWhere, whereArgs: [id]);
  }

  //查询默认地址
  Future<TransportItemModel?> queryDefaultChoose() async {
    //获取db对象
    Database db = await getDatabase();
    //choseWhere 是否有默认地址
    String choseWhere = "$columnIsDefault =?";
    //查询（bool型，用1或者0代替查询）
    var result = await db.query(tableName, where: choseWhere, whereArgs: [1]);
    if (result.isEmpty) {
      return null;
    } else {
      return TransportItemModel.fromJson(result.first);
    }
  }
}
