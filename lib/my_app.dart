import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jd_get_proj/config/route_configs.dart';
import 'package:jd_get_proj/translations/app_translations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget createMyApp() {
  //屏幕无关性控件
  return ScreenUtilInit(
      //原型图尺寸
      designSize: const Size(375, 812),
      builder: () {
        return GetMaterialApp(
            builder: (context, widget) {
              //flutter_screenutil 5.1.1 开始需要以下配置，不然报错，很重要！！！
              ScreenUtil.setContext(context);
              return MediaQuery(
                  //Setting font does not change with system font size
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                  child: widget!);
            },
            debugShowCheckedModeBanner: false,
            //中英文切换
            title: "JD".tr,
            //翻译配置(中英文对照都在：AppTranslations extends Translations)
            translations: AppTranslations(),
            //默认语言(Get.deviceLocale 获取当前设备语言)
            locale: Get.deviceLocale, // const Locale("zh", "CN"),
            //在配置错误下使用的语言 (Get.deviceLocale 获取当前设备语言)
            fallbackLocale: Get.deviceLocale, //const Locale("zh", "CN"),
            //初始化路由
            initialRoute: INIT_PATH,
            //路由页面配置
            getPages: PAGES,
            //未知路由配置
            unknownRoute: UNKNOWN_PAGE);
      });
}
