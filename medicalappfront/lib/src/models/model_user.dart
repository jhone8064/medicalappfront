class UserData {
  String username;
  String password;
  String token;

  UserData({this.username, this.password});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(username: json['username'], password: json['password']);
  }

  Map<String, dynamic> toJson() => {"username": username, "password": password, "token": token};
}
