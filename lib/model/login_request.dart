class SignIn {
  String? username;
  String? password;
  int? tenantId;

  SignIn({this.username, this.password, this.tenantId});

  Map<String, dynamic> toJson() => {
    "username": username,
    "token_type": password,
    "expires_in": tenantId ?? 0,
  };
}
/*  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'],
      userId: json['userId'],
      username: json['username'],
    );
  }*/
