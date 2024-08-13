import 'package:dio/dio.dart';


enum HttpMethod {
  GET,
  POST,
}

class HttpManager {
  // 创建Dio单例对象
  static Dio? _dioInstance;
  static Dio _getDionInstance() {
    _dioInstance ??= Dio(); //如果为空则创建对象
    return _dioInstance!;
  }

  // 返回我们自己的response
  static Future<Response> get(String url, {Map<String, dynamic>? params}) async {
    return await _getDionInstance().get(url, queryParameters: params);
  }
  static Future<Response> post(String url, {Map<String, dynamic>? params,dynamic data}) async {
    return await _getDionInstance().post(url, queryParameters: params,data: data);
  }

  // 自定义发送请求方法
  static sendRequest(HttpMethod method, String url,
      {Map<String, dynamic>? params, dynamic data}) async {
    try {
      switch (method) {
        case HttpMethod.GET:
          return await HttpManager._getDionInstance()
              .get(url, queryParameters: params);
        case HttpMethod.POST:
          return await HttpManager._getDionInstance()
              .post(url, queryParameters: params, data: data);
        default:
          throw Exception('请求方式错误');
      }
    } on DioError catch (e) {
      print(e.message);
    } on Exception catch (e) {
      print(e.toString());
    }
    return null;
  }
}
