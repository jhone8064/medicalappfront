class AuthResponse {
  String accessToken;
  String prefix;
  String message;
  int id;
  String username;

  AuthResponse({this.id, this.username, this.accessToken, this.prefix});
  AuthResponse.error({this.message});

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
        id: json['id'], username: json['username'], accessToken: json['accessToken'], prefix: json['prefix']);
  }

  factory AuthResponse.fromJsonError(Map<String, dynamic> json) {
    return AuthResponse.error(message: json['message']);
  }

  Map<String, dynamic> toJson() =>
      {"accessToken": accessToken, "prefix": prefix};
}
