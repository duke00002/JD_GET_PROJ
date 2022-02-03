import 'dart:async';

import 'package:get/get.dart';
import 'package:jd_get_proj/config/route_configs.dart';
import 'package:jd_get_proj/database/providers/transport_table_provider.dart';
import 'package:jd_get_proj/events/event_bus.dart';
import 'package:jd_get_proj/models/cart_item_model.dart';
import 'package:jd_get_proj/models/transport_item_model.dart';

class OrderController extends GetxController {
  static OrderController get to => Get.find<OrderController>();

  final TransportTableProvider _transportTableProvider =
      TransportTableProvider();

  //被观察对象
  var transportItemModel = TransportItemModel.init().obs;
  //需要下单的商品
  late List<CartItemModel> cartItems;
  //事件句柄
  late StreamSubscription<RefreshAddressEvent> _streamSubscription;

  @override
  void onInit() {
    super.onInit();
    //监听地址刷新事件
    _listenRefreshAddressEvent();
    _getDefaultAddress();
    cartItems = Get.arguments as List<CartItemModel>;
  }

  //监听地址刷新事件
  void _listenRefreshAddressEvent() {
    //事件句柄
    _streamSubscription = eventBus.on<RefreshAddressEvent>().listen((event) {
      //刷新默认地址
      _getDefaultAddress();
    });
  }

  //查询默认地址
  void _getDefaultAddress() async {
    var tempTransportItemModel =
        await _transportTableProvider.queryDefaultChoose();
    //如果查询为空，生成属性全为空的对象
    tempTransportItemModel ??= TransportItemModel.init();
    //obs 更新结果！！！----》通知 obx
    transportItemModel(tempTransportItemModel);
  }

  //去设置地址
  void addAddressTap() async {
    //返回是否需要刷新
    var needRefresh = await Get.toNamed(ADD_ADDRESS_PATH);
    //需要刷新
    if (needRefresh != null && needRefresh) {
      //重新查询默认地址
      _getDefaultAddress();
    }
  }

  //打开地址列表
  void openAddresses() {
    Get.toNamed(RECIPIENT_ADDRESS_PATH);
  }

  void doOrder() {
    print("doOrder");
  }

  @override
  void onClose() {
    //取消监听广播事件
    _streamSubscription.cancel();
    super.onClose();
  }
}
