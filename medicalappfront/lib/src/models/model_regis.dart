class UserRegisData {
  String cedula;
  String nombres;
  String apellidos;
  String username;
  String password;

  UserRegisData(
      {this.cedula,
      this.nombres,
      this.apellidos,
      this.username,
      this.password});

  factory UserRegisData.fromJson(Map<String, dynamic> json) {
    return UserRegisData(
        cedula: json['cedula'],
        nombres: json['nombres'],
        apellidos: json['apellidos'],
        username: json['username'],
        password: json['password']);
  }

  Map<String, dynamic> toJson() => {
        "cedula": cedula,
        "nombres": nombres,
        "apellidos": apellidos,
        "username": username,
        "password": password
      };
}
