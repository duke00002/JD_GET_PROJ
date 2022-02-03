import 'package:dio/dio.dart';
import 'package:jd_get_proj/models/category_model.dart';
import 'package:jd_get_proj/models/focus_model.dart';
import 'package:jd_get_proj/models/pin_code_model.dart';
import 'package:jd_get_proj/models/product_detail_model.dart';
import 'package:jd_get_proj/models/products.dart';
import 'package:jd_get_proj/models/user_login_model.dart';
import 'package:jd_get_proj/rest_tools/file_object.dart';
import 'package:jd_get_proj/rest_tools/rest_core.dart';

class RestApi {
  static const String host = "https://jdmall.itying.com";

  static const String _uploadImageUrl = "/imgupload";

  static const String _focusUrl = "/api/focus";

  static const String _productesUrl = "/api/plist";

  static const String _categoriesUrl = "/api/pcate";

  static const String _productDetailUrl = "/api/pcontent";

  static const String _sendCodeUrl = "/api/sendCode";

  static const String _validateCodeUrl = "/api/validateCode";

  static const String _registerUrl = "/api/register";

  static const String _loginUrl = "/api/doLogin";

  static Future<FocusModel> getFocus() async {
    Response<dynamic> response = await RestCore.getInstance(baseUrl: host)
        .doRestCall(path: _focusUrl, method: Method.GET);

    return FocusModel.fromJson(response.data);
  }

  static Future<Products> getProducts(
      {Map<String, dynamic>? queryParameters}) async {
    Response<dynamic> response = await RestCore.getInstance(baseUrl: host)
        .doRestCall(
            path: _productesUrl,
            method: Method.GET,
            queryParameters: queryParameters);

    return Products.fromJson(response.data);
  }

  static Future<CategoryModel> getCategories(
      {Map<String, dynamic>? queryParameters}) async {
    Response<dynamic> response = await RestCore.getInstance(baseUrl: host)
        .doRestCall(
            path: _categoriesUrl,
            method: Method.GET,
            queryParameters: queryParameters);

    return CategoryModel.fromJson(response.data);
  }

  static Future<ProductDetailModel> getProductDetail(
      {Map<String, dynamic>? queryParameters}) async {
    Response<dynamic> response = await RestCore.getInstance(baseUrl: host)
        .doRestCall(
            path: _productDetailUrl,
            method: Method.GET,
            queryParameters: queryParameters);

    return ProductDetailModel.fromJson(response.data);
  }

  static Future<PinCodeModel> sendPincode(
      {required Map<String, dynamic> body}) async {
    Response<dynamic> response = await RestCore.getInstance(baseUrl: host)
        .doRestCall(path: _sendCodeUrl, method: Method.POST, data: body);

    return PinCodeModel.fromJson(response.data);
  }

  static Future<PinCodeModel> validatePincode(
      {required Map<String, dynamic> body}) async {
    Response<dynamic> response = await RestCore.getInstance(baseUrl: host)
        .doRestCall(path: _validateCodeUrl, method: Method.POST, data: body);

    return PinCodeModel.fromJson(response.data);
  }

  static Future<UserLoginModel> register(
      {required Map<String, dynamic> body}) async {
    Response<dynamic> response = await RestCore.getInstance(baseUrl: host)
        .doRestCall(path: _registerUrl, method: Method.POST, data: body);

    return UserLoginModel.fromJson(response.data);
  }

  static Future<UserLoginModel> login(
      {required Map<String, dynamic> body}) async {
    Response<dynamic> response = await RestCore.getInstance(baseUrl: host)
        .doRestCall(path: _loginUrl, method: Method.POST, data: body);

    return UserLoginModel.fromJson(response.data);
  }

  //上传文件
  static Future<Response<dynamic>> uploadFile(String key, String filePath,
      String fileName, Function(int, int) onSendProgress) {
    FileObject fileObject =
        FileObject(key: key, filePath: filePath, fileName: fileName);

    return RestCore.getInstance(baseUrl: host).postForm(
        path: _uploadImageUrl,
        fileObject: fileObject,
        onSendProgress: onSendProgress);
  }

  //下载文件
  static Future<Response<dynamic>> downloadFile(String urlPath, String savePath,
      {ProgressCallback? progressCallback,
      Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers,
      dynamic body}) {
    return RestCore.getInstance().downloadFile(
        urlPath: urlPath,
        savePath: savePath,
        progressCallback: progressCallback,
        queryParameters: queryParameters,
        headers: headers,
        body: body);
  }
}
