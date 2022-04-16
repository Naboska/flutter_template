import 'package:flutter_template/api/http_managers.dart';

class UserAuthRepository {
  final _client = apiManager.client;

  handleLogin() async {
    final response = await _client.get('/');

    return response;
  }
}
