import 'dart:convert';

import 'package:dio/dio.dart';
//枚举转String方法
import 'package:jd_get_proj/common_tool/enum_to_string.dart';
import 'package:jd_get_proj/rest_tools/file_object.dart';
import 'package:jd_get_proj/rest_tools/my_net_error.dart';

enum Method { GET, POST, PUT, DELETE }

//Rest通讯内核
class RestCore {
  //链接超时配置
  static const int _connectTimeout = 1000 * 30;
  //下载数据超时配置
  static const int _receiveTimeout = 1000 * 30;
  //dio私有对象
  late Dio _dio;

  //私有命名构造函数
  RestCore._privateConstructor({String baseUrl = ''}) {
    //baseUrl:相当于HOST，不传的情况下，就是全链接！！！
    //'https://www.xx.com/api'
    var options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
    );

    _dio = Dio(options);
  }

  //私有静态对象
  static RestCore? _instance;

  //返回对象实例，使用私有命名构造函数
  static RestCore getInstance({String baseUrl = ''}) {
    _instance ??= RestCore._privateConstructor(baseUrl: baseUrl);
    return _instance!;
  }

  //----------以上是最新的Dart单态模式

  //REST请求:公共方法
  Future<Response> _handleRequest(
      {required String path,
      required Method method,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters,
      dynamic body,
      Function(int, int)? onSendProgress,
      Function(int, int)? onReceiveProgress}) {
    Options options =
        Options(method: EnumToString.convertToString(method), headers: headers);
    return _dio.request(path,
        queryParameters: queryParameters,
        data: body,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress);
  }

  //公共方法：处理结果，或者抛出异常：MyNetError
  Response _dealResult(Response<dynamic>? response) {
    if (response == null) {
      throw MyNetError(1001, "无返回信息", data: "无返回信息");
    }

    if (response.statusCode! >= 400) {
      throw MyNetError(response.statusCode!, response.statusMessage ?? "无错误信息",
          data: response.data);
    }
    //成功情况下
    if (response.data is String) {
      //解码String为json
      response.data = json.decode(response.data ?? "{}");
    }

    return response;
  }

  //'GET','POST','PUT','DELETE'
  Future<Response> doRestCall(
      {required String path,
      required Method method,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters,
      dynamic data,
      Function(int, int)? onSendProgress,
      Function(int, int)? onReceiveProgress}) async {
    dynamic response;
    try {
      response = await _handleRequest(
          path: path,
          method: method,
          headers: headers,
          queryParameters: queryParameters,
          body: data,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress);
    } on DioError catch (e) {
      response = e.response;
    }

    // 响应数据
    return _dealResult(response);
  }

  //POST FORM 上传无文件或单个文件
  Future<Response> postForm(
      {required String path,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? formData,
      FileObject? fileObject,
      Function(int, int)? onSendProgress,
      Function(int, int)? onReceiveProgress}) async {
    Map<String, dynamic> map = {};
    //1：增加form参数
    if (formData != null) {
      map.addAll(formData);
    }
    //2：增加form文件参数
    if (fileObject != null) {
      map[fileObject.key] = await MultipartFile.fromFile(fileObject.filePath,
          filename: fileObject.fileName);
    }

    var body = FormData.fromMap(map);

    // var formData = FormData.fromMap({
//   'name': 'wendux',
//   'age': 25,
//   'file': await MultipartFile.fromFile('./text.txt',filename: 'upload.txt')
// });
    return doRestCall(
        path: path,
        method: Method.POST,
        headers: headers,
        queryParameters: queryParameters,
        data: body,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress);
  }

  //下载并保存文件
  Future<Response> downloadFile(
      {required String urlPath,
      required String savePath,
      ProgressCallback? progressCallback,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
      dynamic body}) async {
    Options options = Options(headers: headers, receiveTimeout: 60000);

    dynamic response;
    try {
      response = await _dio.download(urlPath, savePath,
          onReceiveProgress: progressCallback,
          queryParameters: queryParameters,
          data: body,
          options: options);
    } on DioError catch (e) {
      response = e.response;
    }

    /// 响应数据
    return _dealResult(response);

    // this._dio.download(url, savePath, onReceiveProgress: (received, total) {
    //   if (total != -1) {
    //     print((received / total * 100).toStringAsFixed(0) + "%");
    //   }

    //   PackageInfoTool.openFile(savePath).then((result) {
    //     print(result.type);
    //     print(result.message);
    //   });
    // })
  }
}
