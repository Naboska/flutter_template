import 'package:flutter_template/api/http_manager.dart';

class UserAuthRepository {
  final HttpManager httpManager = HttpManager();

  handleLogin() async {
    final response = await httpManager.apiClient.get('/api/user-info');

    return response;
  }
}
