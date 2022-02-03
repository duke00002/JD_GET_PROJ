//网络异常统一格式类
class MyNetError implements Exception {
  final int code;
  final String message;
  final dynamic data;

  MyNetError(this.code, this.message, {this.data});
}
