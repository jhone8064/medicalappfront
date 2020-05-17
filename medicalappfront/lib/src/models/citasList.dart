import 'package:medicalappfront/src/models/model_regiscita.dart';

class CitasList {
  final List<UserRegisCita> lstCitas;

  CitasList({this.lstCitas});

  factory CitasList.fromJson(List<dynamic> citas) {
    List<UserRegisCita> lstCitas = new List<UserRegisCita>();
    lstCitas = citas.map((i) => UserRegisCita.fromJson(i)).toList();

    return new CitasList(
      lstCitas: lstCitas,
    );
  }
}