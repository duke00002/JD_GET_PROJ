import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:jd_get_proj/models/transport_item_model.dart';

//获取地址的输入行
Widget getTextFieldLine(
  double? height,
  String hintTxt,
  int maxLines,
  TextInputType textInputType,
  TextEditingController? controller,
  FocusNode? focusNode,
) {
  return Container(
      height: height,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
      child: TextField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: textInputType,
          textInputAction: TextInputAction.next,
          maxLines: maxLines,
          style: TextStyle(color: Colors.black87, fontSize: 16.sp),
          decoration: InputDecoration(
              //包裹控件（垂直方向，不然会偏移），很重要！！！
              isDense: true,
              //内容padding为空
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              hintText: hintTxt,
              hintStyle:
                  TextStyle(color: Colors.grey.shade500, fontSize: 16.sp))));
}

//获取显示省市区选择行
Widget getAddressTextFieldLine(double? height, String hintTxt, int maxLines,
    TextEditingController? controller, Function()? onAddressTap) {
  return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onAddressTap,
      child: Container(
          height: height,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
          child: Row(children: [
            const Icon(Icons.add_circle),
            SizedBox(width: 5.w),
            Expanded(
                child: TextField(
                    enabled: false,
                    controller: controller,
                    maxLines: maxLines,
                    style: TextStyle(color: Colors.black87, fontSize: 16.sp),
                    decoration: InputDecoration(
                        //包裹控件（垂直方向，不然会偏移），很重要！！！
                        isDense: true,
                        //内容padding为空
                        contentPadding: EdgeInsets.zero,
                        border: InputBorder.none,
                        hintText: hintTxt,
                        hintStyle: TextStyle(
                            color: Colors.grey.shade500, fontSize: 16.sp))))
          ])));
}

//获取默认选中地址Line
Widget getIsDefalutLine(
    double? height, bool checked, Function(bool?)? onChanged) {
  return Container(
      height: height,
      padding: EdgeInsets.all(10.w),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.grey.shade300))),
      child: Row(children: [
        Theme(
            data: ThemeData(
                //未选中边框色
                unselectedWidgetColor: Colors.grey,
                //点击色处理
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent),
            child: Checkbox(
                //选中勾的颜色
                checkColor: Colors.white,
                //选中背景色
                activeColor: Colors.red,
                value: checked,
                onChanged: onChanged)),
        Text("default_address".tr,
            style: TextStyle(color: Colors.black87, fontSize: 16.sp))
      ]));
}

//获取底部按钮
Widget getAddressBottom(String title, Function()? onBtnTap) {
  return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: onBtnTap,
      child: Container(
        height: 50.h,
        color: Colors.red,
        alignment: Alignment.center,
        child:
            Text(title, style: TextStyle(color: Colors.white, fontSize: 16.sp)),
      ));
}

//获取地址列表
Widget getAddressListView(
    List<TransportItemModel> addresses,
    Function(TransportItemModel)? onEdit,
    Function(TransportItemModel)? onDelete) {
  return ListView.separated(
      itemBuilder: (context, index) {
        return getAddressSlidableView(addresses[index], onEdit, onDelete);
      },
      separatorBuilder: (context, index) {
        return Divider(height: 1, color: Colors.grey.shade300);
      },
      itemCount: addresses.length);
}

//获取地址滑动Item
Widget getAddressSlidableView(
    TransportItemModel transportItemModel,
    Function(TransportItemModel)? onEdit,
    Function(TransportItemModel)? onDelete) {
  //横向滑动按钮组件
  return Slidable(
      //尾部触发组件
      endActionPane: ActionPane(
          //行为滑动
          motion: const ScrollMotion(),
          //占item的百分比显示滑动按钮(划出宽度)
          extentRatio: 140.w / 375.w,
          children: [
            //如果嵌套：外层必须是支持flex的父控件（如Row或Column ）！！！
            //滑动按钮
            //编辑按钮
            SlidableAction(
                flex: 1,
                onPressed: (context) {
                  onEdit!(transportItemModel);
                },
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                icon: Icons.edit_outlined),
            SlidableAction(
                flex: 1,
                onPressed: (context) {
                  onDelete!(transportItemModel);
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete_outlined)
          ]),
      child: ListTile(
          leading: transportItemModel.isDefault!
              ? Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: const Icon(Icons.check, color: Colors.red))
              : null,
          title: Text("${transportItemModel.name} ${transportItemModel.phone}",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.black87, fontSize: 14.sp)),
          subtitle: Padding(
              padding: EdgeInsets.only(top: 10.h),
              child: Text(
                  "${transportItemModel.province}${transportItemModel.city}${transportItemModel.district}${transportItemModel.address}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.grey.shade500, fontSize: 14.sp)))));
}
