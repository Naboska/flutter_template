import 'package:dio/dio.dart';

import 'package:flutter_template/constants/env.dart';

class HttpManager {
  final Dio _dio = Dio();
  static String? token;

  HttpManager() {
    _dio.options.baseUrl = Env.clientUrl;
    _dio.interceptors.add(InterceptorsWrapper(
        onRequest: _onRequest, onResponse: _onResponse, onError: _onError));
  }

  _onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (token != null) options.headers["Authorization"] = "Bearer $token";

    return handler.next(options);
  }

  _onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }

  _onError(DioError error, ErrorInterceptorHandler handler) {
    //if (error.response?.statusCode == 401) AuthenticationBloc().logout();

    return handler.next(error);
  }

  Dio get client => _dio;
}
