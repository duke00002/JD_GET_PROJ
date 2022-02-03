import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:jd_get_proj/category/category_controller.dart';
import 'package:jd_get_proj/category/category_gridview.dart';
import 'package:jd_get_proj/category/category_listview.dart';
import 'package:jd_get_proj/common_tool/app_bar_widget.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    //添加一下段，不然会提示警告
    super.build(context);
    return Scaffold(
        appBar: AppBarWidget.getAppBar(
            CategoryController.to.openScanner,
            CategoryController.to.goSearchPage,
            CategoryController.to.messageCount.value,
            CategoryController.to.goMessagePage),
        body: Container(
            color: const Color.fromARGB(64, 204, 255, 255),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: 80.w, child: _getCategories()),
                  Expanded(
                      flex: 1,
                      child: Padding(
                          padding: EdgeInsets.all(10.w),
                          child: _getSubCategories()))
                ])));
  }

  Widget _getCategories() {
    //必须取！！！：RxInt的value值，才会触发改变
    return Obx(() {
      return CategoryController.to.categories.isNotEmpty
          ? getCategoryListView(
              CategoryController.to.categories,
              //必须取！！！：RxInt的value值，才会触发改变
              CategoryController.to.selectedIndex.value,
              CategoryController.to.leftCategoryTapped)
          : const SizedBox(width: 0);
    });
  }

  Widget _getSubCategories() {
    return Obx(() {
      return CategoryController.to.subCategories.isNotEmpty
          ? getCategoryGridView(CategoryController.to.subCategories,
              CategoryController.to.goProductList)
          : const SizedBox(width: 0);
    });
  }

  @override
  bool get wantKeepAlive => true;
}
