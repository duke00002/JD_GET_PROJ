import 'package:event_bus/event_bus.dart';

//事件传输插件
//eventBus 总线，一个app只有一个
EventBus eventBus = EventBus();

//Event事件
class JumpToTabEvent {
  final int _tabIndex;
  JumpToTabEvent(this._tabIndex);

  int get tabIndex => _tabIndex;
}

//刷新地址事件
class RefreshAddressEvent {}

//刷新用户
class RefreshUser {}
