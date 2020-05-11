class UserRegisCita {
  String cedula;
  String telefono;
  String motivo;
  

  UserRegisCita(
      {this.cedula,
      this.telefono,
      this.motivo
      });

  factory UserRegisCita.fromJson(Map<String, dynamic> json) {
    return UserRegisCita(
        cedula: json['cedula'],
        telefono: json['telefono'],
        motivo: json['motivo']
        );
  }

  Map<String, dynamic> toJson() => {
        "cedula": cedula,
        "telefono": telefono,
        "motivo": motivo
        
      };
}
