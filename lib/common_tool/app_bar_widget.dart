import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jd_get_proj/common_tool/message_widget.dart';
import 'package:jd_get_proj/common_tool/search_bar.dart';

class AppBarWidget {
  static AppBar getAppBar(Function()? openScanner, Function()? onTapSearch,
      int messageCount, Function()? onTapMessage) {
    return AppBar(
        elevation: 2.h,
        //与leading的边距和actions的边距
        titleSpacing: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            icon: const Icon(Icons.photo_camera, color: Colors.black87),
            onPressed: openScanner),
        title: _getSearch(onTapSearch),
        actions: [_getMessageWidget(messageCount, onTapMessage)]);
  }

  static Widget _getSearch(Function()? onTapSearch) {
    return InkWell(onTap: onTapSearch, child: getHomeSearchBar());
  }

  static Widget _getMessageWidget(int messageCount, Function()? onTapMessage) {
    return InkWell(onTap: onTapMessage, child: getMessageWidget(messageCount));
  }
}
