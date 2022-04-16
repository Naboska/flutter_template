import 'package:dio/dio.dart';

import '../http_managers.dart';

class UnauthorizedInterceptor {
  final Dio client = apiManager.client;
  late final Interceptor _interceptor;

  UnauthorizedInterceptor(Function callback) {
    _interceptor = _Interceptor(callback);
    client.interceptors.add(_interceptor);
  }

  void remove() {
    client.interceptors.remove(_interceptor);
  }
}

class _Interceptor extends Interceptor {
  final Function callback;

  _Interceptor(this.callback);

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    callback();
    if (err.response?.statusCode == 401) callback();

    return handler.next(err);
  }
}