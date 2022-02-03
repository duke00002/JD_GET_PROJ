//生成表
import 'package:jd_get_proj/database/providers/cart_table_provider.dart';
import 'package:jd_get_proj/database/providers/transport_table_provider.dart';

//生成表（初始化）
Future<bool> createTables() async {
  CartTableProvider cartTableProvider = CartTableProvider();
  TransportTableProvider transportTableProvider = TransportTableProvider();
  await cartTableProvider.createTable();
  await transportTableProvider.createTable();
  return true;
}
