import 'package:flutter_template/api/http_manager.dart';

class UserAuthRepository {
  final HttpManager httpManager = HttpManager();

  handleLogin() async {
    //TODO for test delayed
    await Future.delayed(const Duration(seconds: 2));
    final response = await httpManager.apiClient.get('/');

    return response;
  }
}
