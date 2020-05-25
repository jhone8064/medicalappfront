class UserRegisCita {
  String cedula;
  String numero;
  String motivo;
  DateTime fecha;
  String id;
  String idCita;
  int estado;

  UserRegisCita(
      {this.cedula,
      this.numero,
      this.motivo,
      this.fecha,
      this.id,
      this.estado,
      this.idCita});

  factory UserRegisCita.fromJson(Map<String, dynamic> json) {    
    return UserRegisCita(
      cedula: json['cedula'],
      numero: json['numero'],
      motivo: json['motivo'],
      fecha: DateTime.parse(json['fecha']),
      id: json['id'],
      estado: json['estado'],
      idCita: json['idCita']
    );
  }

  Map<String, dynamic> toJson() => {
        "cedula": cedula,
        "numero": numero,
        "motivo": motivo,
        "fecha": fecha.toString(),
        "id": id,
      };

       Map<String, dynamic> toJson2() => {
        "cedula": cedula,
        "numero": numero,
        "motivo": motivo,
        "fecha": fecha.toString(),
        "id": id,
        "idCita": idCita,
        "estado": estado
      };

   String strEstado() {     
     if(this.estado == 0){
       return 'Cancelada';
     } else if(this.estado == 1){
       return 'Agendada';
     }
     return 'Sin estado';
   }  

   bool isEnable(){
     if(this.estado == 0){
       return false;
     }
     return true;
   }
}
