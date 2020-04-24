import 'dart:async';
import 'ApiServiceLogin.dart';
import '../models/model_user.dart';
import '../models/model_regis.dart';
import 'package:medicalappfront/src/models/apiResponse.dart';

class Repository {
  final ApiLogin apiLogin = ApiLogin();

  Future<ApiResponse> login(UserData userData) => apiLogin.login(userData);
  
  Future<ApiResponse> registrar(UserRegisData userData) => apiLogin.registrar(userData);

  
}