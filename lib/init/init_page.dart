import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InitPage extends StatelessWidget {
  const InitPage({Key? key}) : super(key: key);

  final String JD_URL =
      "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimgsa.baidu.com%2Fexp%2Fw%3D500%2Fsign%3D89f839a277310a55c424def487444387%2F6f061d950a7b0208053a9cb06cd9f2d3562cc8f4.jpg&refer=http%3A%2F%2Fimgsa.baidu.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1645008793&t=23f4b95f5e8df3b491fc69359c2fb8d3";

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: JD_URL,
        fit: BoxFit.cover,
        width: Get.width,
        height: Get.height);
  }
}
