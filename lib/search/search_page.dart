import 'package:flutter/material.dart';
import 'package:jd_get_proj/search/search_bar.dart';
import 'package:jd_get_proj/search/search_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: getSearchBar(
            null,
            SearchController.to.focusNode,
            SearchController.to.controller,
            SearchController.to.searchTapped,
            SearchController.to.onSubmitted),
        body: _getSearchView());
  }

  Widget _getSearchView() {
    return Obx(() {
      return SearchController.to.searchList.isNotEmpty
          ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                  padding: EdgeInsets.all(10.w),
                  child: Text("search_his".tr,
                      style:
                          TextStyle(color: Colors.black87, fontSize: 16.sp))),
              Divider(height: 1, color: Colors.grey.shade400),
              Expanded(child: _getListView()),
              InkWell(
                  onTap: SearchController.to.clearSearchList,
                  child: Container(
                      width: 375.w,
                      height: 60.h,
                      color: Colors.blue,
                      alignment: Alignment.center,
                      child: Text("clear_search_his".tr,
                          style:
                              TextStyle(color: Colors.white, fontSize: 16.sp))))
            ])
          : const SizedBox(height: 0);
    });
  }

  Widget _getListView() {
    return ListView.separated(
        itemBuilder: (context, index) {
          return InkWell(
              onTap: () {
                SearchController.to
                    .onSubmitted(SearchController.to.searchList[index]);
              },
              child: ListTile(
                  title: Text(SearchController.to.searchList[index],
                      style:
                          TextStyle(color: Colors.black87, fontSize: 14.sp))));
        },
        separatorBuilder: (context, index) {
          return Divider(height: 1, color: Colors.grey.shade400);
        },
        itemCount: SearchController.to.searchList.length);
  }
}
