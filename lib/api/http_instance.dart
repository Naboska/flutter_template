import 'package:dio/dio.dart';

import 'package:flutter_template/api/constants.dart';
import 'package:flutter_template/api/helpers/storage_service.dart';

class HttpInstance {
  final StorageService _storageService = StorageService();
  final Dio _dio = Dio();

  HttpInstance({required String baseUrl}) {
    _dio.options.baseUrl = baseUrl;
    _dio.interceptors.add(InterceptorsWrapper(onRequest: _onRequest, onResponse: _onResponse));
  }

  _onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    String? token = await _storageService.read(HttpConstants.accessTokenKey);
    if (token != null) options.headers["Authorization"] = "Bearer $token";

    return handler.next(options);
  }

  _onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response.data);
  }

  Dio get client => _dio;
}
