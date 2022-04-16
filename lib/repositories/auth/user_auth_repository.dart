import 'package:flutter_template/api/http_managers.dart';

class UserAuthRepository {
  final _client = apiManager.client;

  handleLogin() async {
    //TODO for test delayed
    await Future.delayed(const Duration(seconds: 2));
    final response = await _client.get('/');

    return response;
  }
}
