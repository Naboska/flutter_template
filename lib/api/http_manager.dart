import 'package:dio/dio.dart';
import 'package:flutter_template/constants/env.dart';
import './http_instance.dart';

class HttpManager {
  static final HttpInstance _apiManager = HttpInstance(Env.clientUrl);

  Dio get apiClient => _apiManager.client;
}