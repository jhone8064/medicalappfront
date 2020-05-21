import 'package:rxdart/rxdart.dart';
import 'package:medicalappfront/src/blocs/authorization_bloc.dart';
//import 'package:front_hemosugar/src/models/model_user.dart';
import 'package:medicalappfront/src/blocs/validator.dart';
import 'package:medicalappfront/src/models/model_regis.dart';
import 'package:medicalappfront/src/resources/repository.dart';
//import 'package:flutter/material.dart';

class ConsultaBloc extends Validators {
  final _repository = Repository();
  final _user = PublishSubject<UserRegisData>();

  Stream<UserRegisData> get infoUser => _user.stream;    
  
  getInfoUser() async {
    String id = await authBloc.getId();
    UserRegisData user = await _repository.infoUser(id);    
    _user.sink.add(user);
    //return user;
  } 

  dispose() {
    _user.close();
  }

  logoutUser() {
    authBloc.closeSession();    
    _user.close();    
  }
}

final consultaBloc = ConsultaBloc();