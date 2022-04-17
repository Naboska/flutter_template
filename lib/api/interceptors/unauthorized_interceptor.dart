import 'package:dio/dio.dart';

import '../http_manager.dart';

class UnauthorizedInterceptor {
  final HttpManager httpManager = HttpManager();
  late final Interceptor _interceptor;

  UnauthorizedInterceptor(Function callback) {
    _interceptor = _Interceptor(callback);
    httpManager.apiClient.interceptors.add(_interceptor);
  }

  void remove() {
    httpManager.apiClient.interceptors.remove(_interceptor);
  }
}

class _Interceptor extends Interceptor {
  final Function callback;

  _Interceptor(this.callback);

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) callback();

    return handler.next(err);
  }
}