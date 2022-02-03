import 'package:jd_get_proj/common_tool/sort_model.dart';
import 'package:get/get.dart';

List<SortModel> getSortList() {
  var list = <SortModel>[];
  list.add(SortModel(title: "genaric".tr, sortType: SortType.genaric));
  list.add(SortModel(title: "sold".tr, sortType: SortType.sold));
  list.add(SortModel(title: "price".tr, sortType: SortType.price));
  return list;
}

List<SortModel> getSortDetailList() {
  var list = <SortModel>[];
  list.add(SortModel(title: "product".tr, sortType: SortType.product));
  list.add(
      SortModel(title: "product_detail".tr, sortType: SortType.product_detail));
  list.add(SortModel(
      title: "product_comment".tr, sortType: SortType.product_comment));
  return list;
}
