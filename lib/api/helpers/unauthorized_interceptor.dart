import 'package:dio/dio.dart';
import 'package:flutter_template/constants/env.dart';
import 'package:flutter_template/models/auth/auth_credentials.dart';

import '../http_manager.dart';
import '../constants.dart';
import 'storage_service.dart';

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
  final StorageService _storageService = StorageService();
  final Function callback;

  _Interceptor(this.callback);

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      String? refreshToken = await _storageService.read(HttpConstants.refreshTokenKey);

      if (refreshToken == null) {
        callback();
        return handler.next(err);
      }

      try {
        Dio dio = Dio(
          BaseOptions(
            baseUrl: Env.clientUrl
          )
        );

        final authCredentialsResponse = await dio.post('/api/token/refresh', data: { 'refreshToken': refreshToken });
        final authCredentials = AuthCredentialsModel.fromJson(authCredentialsResponse.data['data']);

        _storageService.write(StorageItemModel(key: HttpConstants.accessTokenKey, value: authCredentials.token));
        _storageService.write(StorageItemModel(key: HttpConstants.refreshTokenKey, value: authCredentials.refreshToken));

        final RequestOptions requestOptions = err.response!.requestOptions;
        requestOptions.headers['Authorization'] = 'Bearer ${authCredentials.token}';

        final response = await dio.request(
          requestOptions.path,
          data: requestOptions.data,
          queryParameters: requestOptions.queryParameters,
          options: Options(
            method: requestOptions.method,
            headers: requestOptions.headers,
          )
        );

        return handler.resolve(response);
      } catch (error) {
        await Future.wait([_storageService.delete(HttpConstants.accessTokenKey), _storageService.delete(HttpConstants.refreshTokenKey)]);
        callback();
      }
    }

    return handler.next(err);
  }
}
