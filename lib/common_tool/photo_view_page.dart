import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:get/get.dart';

class PhotoViewPage extends StatelessWidget {
  const PhotoViewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("photo_view".tr),
            centerTitle: true,
            backgroundColor: Colors.black),
        body: Container(
            color: Colors.black,
            child: PhotoView(
                //最小缩放率，保持最小就是原图大小
                minScale: PhotoViewComputedScale.contained,
                imageProvider: NetworkImage(Get.parameters["url"]!))));
  }
}
