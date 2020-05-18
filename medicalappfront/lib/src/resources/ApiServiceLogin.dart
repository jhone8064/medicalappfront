import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:medicalappfront/src/models/apiResponse.dart';
import 'package:http/http.dart';
import 'package:medicalappfront/src/models/model_regiscita.dart';
import 'dart:convert';
import 'package:medicalappfront/src/models/model_user.dart';
import 'package:medicalappfront/src/models/model_regis.dart';
import 'package:medicalappfront/src/Constants.dart';
import 'package:flutter/foundation.dart';



class ApiLogin {
  Client client = Client();
  ApiResponse _apiResponse;
  UserRegisData _userRegisData;
  //UserRegisCita _userRegisCita;
 //final _listaCita = List<UserRegisCita>();
  

  Future<ApiResponse> login(UserData userData) async {
    var body = jsonEncode(userData.toJson());    
    Uri uri = Uri.https(Constants.urlAuthority, Constants.urlAuth);

    var res = await client.post(uri,
        headers: {HttpHeaders.contentTypeHeader: Constants.contentTypeJson},
        body: body);

    if (res.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      _apiResponse = ApiResponse.fromJson({'data': res.body});
    } else {
      _apiResponse = ApiResponse.fromJson(jsonDecode(res.body));
    }
    return _apiResponse;
  }

   Future<ApiResponse> registrar(UserRegisData userData) async {
    var body = jsonEncode(userData.toJson());
    Uri uri = Uri.https(Constants.urlAuthority, Constants.urlRegi);
   
    var res = await client.post(uri,
        headers: {HttpHeaders.contentTypeHeader: Constants.contentTypeJson},
        body: body);
    debugPrint(res.body);
    if (res.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      _apiResponse = ApiResponse.fromJson({'data': res.body});
    } else {
      _apiResponse = ApiResponse.fromJson(jsonDecode(res.body));
    }
    return _apiResponse;
  }

 
 Future<ApiResponse> registrarCita(UserRegisCita userRegisCita) async {
    var body = jsonEncode(userRegisCita.toJson());
    Uri uri = Uri.https(Constants.urlAuthority, Constants.urlRegisCita);
   debugPrint('LLEGA 1.1');
    var res = await client.post(uri,
        headers: {HttpHeaders.contentTypeHeader: Constants.contentTypeJson},
        body: body);
        debugPrint('LLEGA 1.2');
    debugPrint(res.body);
    debugPrint('LLEGA 1.3 ' + res.statusCode.toString());
    if (res.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      _apiResponse = ApiResponse.fromJson({'data': res.body});
    } else {
      _apiResponse = ApiResponse.fromJson(jsonDecode(res.body));
    }
    return _apiResponse;
  }

  Future<UserRegisData> infoUser(String id) async {        
    var res = await client.get('https://'+Constants.urlAuthority+'/infoUser?id='+id);       
    if (res.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      _userRegisData = UserRegisData.fromJson(jsonDecode(res.body));            
    } else {
      _userRegisData = UserRegisData.fromJson(jsonDecode(res.body));
    }
    return _userRegisData;
  }

  /*Future<UserRegisCita> infoCita(String id) async {        
    var res = await client.get('https://'+Constants.urlAuthority+'/infoCita?cedula='+id);       
    if (res.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      _userRegisCita = UserRegisCita.fromJson(jsonDecode(res.body));            
    } else {
      _userRegisCita = UserRegisCita.fromJson(jsonDecode(res.body));
    }
    return _userRegisCita;
  }*/
  
}
