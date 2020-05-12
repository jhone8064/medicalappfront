class UserRegisCita {
  String cedula;
  String numero;
  String motivo;
  String fecha;
  String id;
 // String hora;
  

  UserRegisCita(
      {this.cedula,
      this.numero,
      this.motivo,
      this.fecha,
      this.id
//this.hora
      });

  factory UserRegisCita.fromJson(Map<String, dynamic> json) {
    return UserRegisCita(
        cedula: json['cedula'],
        numero: json['numero'],
        motivo: json['motivo'],
        fecha: json['fecha']        
      //  hora: json['hora']
        
        );
  }

  Map<String, dynamic> toJson() => {
        "cedula": cedula,
        "numero": numero,
        "motivo": motivo,
        "fecha": fecha,
        "id":id
        //"hora": hora
        
      };
}
