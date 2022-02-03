import 'package:jd_get_proj/database/providers/base_table_provider.dart';
import 'package:jd_get_proj/models/cart_item_model.dart';
import 'package:sqflite/sqflite.dart';

//目标表的类
class CartTableProvider extends BaseTableProvider {
  //表名
  static const String tableName = "cart";
  //表列名
  static const String columnId = "id";
  //商品ID
  static const String columnProductId = "product_id";
  //商品图片
  static const String columnImage = "image";
  //商品名称
  static const String columnTitle = "title";
  //商品属性
  static const String columnAttrs = "attrs";
  //商品单价
  static const String columnPrice = "price";
  //购买个数
  static const String columnCount = "count";
  //购买时间
  static const String columnTime = "time";

  @override
  String getTableName() {
    return tableName;
  }

  //''' 代表多行字符串
  @override
  String getCreateTableSql() {
    return '''CREATE TABLE $tableName(
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnProductId TEXT NOT NULL,
      $columnImage TEXT NOT NULL,
      $columnTitle TEXT NOT NULL,
      $columnAttrs TEXT NOT NULL,
      $columnPrice INTEGER NOT NULL,
      $columnCount INTEGER NOT NULL,
      $columnTime INTEGER NOT NULL
    )''';
  }

  //增加购物车货品，查询后决定是新增还是更新
  Future<int> add(CartItemModel cartItemModel) async {
    //获取db对象
    Database db = await getDatabase();
    //查询是否已经有相同属性的商品存在语句
    String queryWhere = "$columnProductId =? AND $columnAttrs =?";
    //查询是否存在
    var result = await db.query(tableName,
        where: queryWhere,
        whereArgs: [cartItemModel.productId, cartItemModel.attrs]);
    //不存在
    if (result.isEmpty) {
      return await db.insert(tableName, cartItemModel.toJson());
    } else {
      //更新个数
      var tempData = result.first;
      //增加个数在原来基础上
      cartItemModel.count =
          cartItemModel.count! + int.parse(tempData[columnCount]!.toString());
      //ID where
      String updateWhere = "$columnId =?";
      //更新
      return await db.update(tableName, cartItemModel.toJson(),
          where: updateWhere, whereArgs: [tempData[columnId]]);
    }
  }

  Future<int> update(CartItemModel cartItemModel) async {
    //获取db对象
    Database db = await getDatabase();
    //ID where
    String updateWhere = "$columnId =?";
    //更新
    return await db.update(tableName, cartItemModel.toJson(),
        where: updateWhere, whereArgs: [cartItemModel.id!]);
  }

  //按照时间降序查询所有
  Future<List<CartItemModel>> queryAll() async {
    //获取db对象
    Database db = await getDatabase();
    //返回的结果
    var result = await db.query(tableName, orderBy: "$columnTime desc");
    //生成对象结果
    return result.map((e) {
      return CartItemModel.fromJson(e);
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
}
