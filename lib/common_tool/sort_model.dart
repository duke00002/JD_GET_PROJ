enum SortType { genaric, sold, price, product, product_detail, product_comment }

class SortModel {
  String title;
  SortType sortType;
  bool isDown;

  SortModel({required this.title, required this.sortType, this.isDown = true});
}
