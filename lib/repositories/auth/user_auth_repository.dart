import 'package:flutter_template/api/http_manager.dart';

class UserAuthRepository {
  final _client = HttpManager().client;

  handleLogin() async {
    final response = await _client.get('/');

    return response;
  }
}
