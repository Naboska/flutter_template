class AuthCredentialsModel {
  late String token;
  late String refreshToken;

  AuthCredentialsModel({required this.token, required this.refreshToken});

  AuthCredentialsModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    refreshToken = json['refreshToken'];
  }
}
