//import 'dart:convert';


import 'package:rxdart/rxdart.dart';
import 'package:medicalappfront/src/blocs/authorization_bloc.dart';
//import 'package:front_hemosugar/src/models/model_user.dart';
import 'package:medicalappfront/src/blocs/validator.dart';
import 'package:medicalappfront/src/models/model_regis.dart';
import 'package:medicalappfront/src/resources/repository.dart';
import 'package:flutter/material.dart';

class ConsultaBloc extends Validators {
  Repository repository = Repository();

 

  final _user = PublishSubject<UserRegisData>();
  Stream<UserRegisData> get infoUser => _user.stream;

  final BehaviorSubject _glucemiaController = BehaviorSubject<String>();
  final PublishSubject _loadingData = PublishSubject<bool>();

  Function(String) get changeGlucemia => _glucemiaController.sink.add;





  Stream<bool> get loading => _loadingData.stream;

  getInfoUser() async {
    String id = await authBloc.getId();
    UserRegisData user = await repository.infoUser(id);
    debugPrint(user.cedula);
    _user.sink.add(user);
    return user;
  }



 

  logoutUser() {
    authBloc.closeSession();
    _glucemiaController.close();
    _user.close();
    _loadingData.close();
  }
}

final consultaBloc = ConsultaBloc();
