class UserRegisCita {
  String cedula;
  String numero;
  String motivo;
  DateTime fecha;
  String id;

  UserRegisCita({this.cedula, this.numero, this.motivo, this.fecha, this.id});

  factory UserRegisCita.fromJson(Map<String, dynamic> json) {
    return UserRegisCita(
      cedula: json['cedula'],
      numero: json['numero'],
      motivo: json['motivo'],
      fecha: DateTime.parse(json['fecha']),
    );
  }

  Map<String, dynamic> toJson() => {
        "cedula": cedula,
        "numero": numero,
        "motivo": motivo,
        "fecha": fecha.toString(),
        "id": id,
      };
}
