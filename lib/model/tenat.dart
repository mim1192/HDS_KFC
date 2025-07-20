class TenAt {
  String? username;
  String? password;
  int? tenantId;

  TenAt({this.username, this.password, this.tenantId});

  // Convert the Tenant object to JSON
  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,  // It seems you intended to map the password field correctly.
    "tenantId": tenantId ?? 0,  // Default value for tenantId is 0 if it's null
  };

  // Optionally, a factory method to convert a JSON response back into a Tenant object
  factory TenAt.fromJson(Map<String, dynamic> json) {
    return TenAt(
      username: json['username'],
      password: json['password'],
      tenantId: json['tenantId'] ?? 0, // Fallback to 0 if tenantId is null
    );
  }
}
