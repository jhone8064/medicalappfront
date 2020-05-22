import 'dart:async';
import 'package:medicalappfront/src/models/citasList.dart';
import 'package:medicalappfront/src/models/model_regiscita.dart';
import 'package:medicalappfront/src/resources/citas_provider.dart';

import 'ApiServiceLogin.dart';
import '../models/model_user.dart';
import '../models/model_regis.dart';
import 'package:medicalappfront/src/models/apiResponse.dart';

class Repository {
  final ApiLogin apiLogin = ApiLogin();
  final CitasProvider citasProvider = CitasProvider();

  Future<ApiResponse> login(UserData userData) => apiLogin.login(userData);
  
  Future<ApiResponse> registrar(UserRegisData userData) => apiLogin.registrar(userData);
 
  Future<ApiResponse> registrarCita(UserRegisCita userRegisCita) => apiLogin.registrarCita(userRegisCita);
  
  Future<UserRegisData> infoUser(String id) => apiLogin.infoUser(id);

  Future<CitasList> fetchAllCitas(String accesToken) =>
      citasProvider.infoCitas(accesToken);

  Future<CitasList> fetchAllCitasFecha(String accesToken, String fecha) =>
      citasProvider.infoCitasFecha(accesToken, fecha);
}