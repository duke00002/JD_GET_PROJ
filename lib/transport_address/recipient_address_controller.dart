import 'package:get/get.dart';
import 'package:jd_get_proj/common_tool/message_widget.dart';
import 'package:jd_get_proj/config/route_configs.dart';
import 'package:jd_get_proj/database/providers/transport_table_provider.dart';
import 'package:jd_get_proj/events/event_bus.dart';
import 'package:jd_get_proj/models/transport_item_model.dart';

class RecipientAddressController extends GetxController {
  static RecipientAddressController get to =>
      Get.find<RecipientAddressController>();

  final TransportTableProvider _transportTableProvider =
      TransportTableProvider();

  var addresses = <TransportItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _getAddresses();
  }

  void _getAddresses() async {
    addresses.clear();
    addresses.addAll(await _transportTableProvider.queryAll());
  }

  void onItemEdit(TransportItemModel transportItemModel) async {
    //返回是否需要刷新
    var needRefresh =
        await Get.toNamed(ADD_ADDRESS_PATH, arguments: transportItemModel);
    //需要刷新
    if (needRefresh != null && needRefresh) {
      //重新查询地址列表
      _getAddresses();
      //需要发送广播
      _sendRefreshAddressEvent();
    }
  }

  void onItemDelete(TransportItemModel transportItemModel) async {
    //弹框提示
    var result = await showDialog(
        "notice".tr, "delete_notice".tr, "confirm".tr, "cancel".tr);
    //如果确定则删除
    if (result) {
      await _transportTableProvider.delete(transportItemModel.id!);
      //重新查询地址列表
      _getAddresses();
      //需要发送广播
      _sendRefreshAddressEvent();
    }
  }

  void onBtnTap() async {
    //返回是否需要刷新
    var needRefresh = await Get.toNamed(ADD_ADDRESS_PATH);
    //需要刷新
    if (needRefresh != null && needRefresh) {
      //重新查询地址列表
      _getAddresses();
      //需要发送广播
      _sendRefreshAddressEvent();
    }
  }

  //需要发送广播,刷新订单页
  void _sendRefreshAddressEvent() {
    //发送事件
    eventBus.fire(RefreshAddressEvent());
  }

  @override
  void onClose() {
    super.onClose();
  }
}
