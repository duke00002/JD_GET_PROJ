import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnknownPage extends StatelessWidget {
  const UnknownPage({Key? key}) : super(key: key);

  static const String URL_404 =
      "https://gimg2.baidu.com/image_search/src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fq_70%2Cc_zoom%2Cw_640%2Fimages%2F20171215%2Fcceac8ac0105474a8c1a768588040427.jpeg&refer=http%3A%2F%2F5b0988e595225.cdn.sohucs.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1645009242&t=2c27c218b8bbe8562020dfaf114bf759";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("404".tr), centerTitle: true),
        body: Container(
            color: Colors.white,
            child: Center(
                child: CachedNetworkImage(
                    imageUrl: URL_404, fit: BoxFit.fitWidth))));
  }
}
