import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:medicalappfront/src/models/model_regiscita.dart';
//import 'package:medicalappfront/src/ui/ui_login.dart';
//import 'package:medicalappfront/src/ui/ui_registrarcita.dart';
import 'package:rxdart/rxdart.dart';
import 'package:medicalappfront/src/blocs/validator.dart';
import 'package:medicalappfront/src/models/apiResponse.dart';
import 'package:medicalappfront/src/resources/repository.dart';
import 'package:medicalappfront/src/blocs/authorization_bloc.dart';
import 'package:flutter/material.dart';

class RegistrarCitaBloc extends Validators {
  final _repository = Repository();

  final BehaviorSubject _cedulaController = BehaviorSubject<String>();
  final BehaviorSubject _numeroController = BehaviorSubject<String>();
  final BehaviorSubject _motivoController = BehaviorSubject<String>();
  final BehaviorSubject _fechaController = BehaviorSubject<String>();
  //final BehaviorSubject _horaController = BehaviorSubject<String>();
  //final PublishSubject _loadingData = PublishSubject<bool>();

  Function(String) get changeCedula => _cedulaController.sink.add;
  Function(String) get changeNumero => _numeroController.sink.add;
  Function(String) get changeMotivo => _motivoController.sink.add;
  Function(String) get changeFecha => _fechaController.sink.add;
  //Function(String) get changeHora => _horaController.sink.add;

  Stream<String> get cedula => _cedulaController.stream.transform(validateCedula);
  Stream<String> get numero =>  _numeroController.stream.transform(validateNombres);
  Stream<String> get motivo => _motivoController.stream.transform(validateApellidos);
  Stream<String> get fecha => _fechaController.stream.transform(validateNombres);
  //Stream<String> get hora => _horaController.stream.transform(validateApellidos);
  DateTime fechaHora = DateTime.now();// => _fechaController.transform(validateDate);
  
  Stream<bool> get submitValid => Rx.combineLatest4(
      cedula,
      numero,
      motivo,
      fecha,
    //  hora,
      (cedula, numero, motivo, fecha) => true);

  //Stream<bool> get loading => _loadingData.stream;

  void submit(BuildContext context) {
    final validCedula = _cedulaController.value;
    final validNumero = _numeroController.value;
    final validMotivo = _motivoController.value;
    //final validFecha = _fechaController.value;
    //final validHora = _horaController.value;
    //final validid = authBloc.getId();     

    UserRegisCita user = new UserRegisCita(
        cedula: validCedula,
        numero: validNumero,
        motivo: validMotivo,
        //fecha: validFecha,
        id: "",
       // hora: validHora
        );
    //_loadingData.sink.add(true);
    registrarCita(user, context);
  }

  registrarCita(UserRegisCita authRequest, BuildContext context) async {
    authRequest.id = await authBloc.getId();
    authRequest.fecha = fechaHora.toString();
    ApiResponse apiresponse = await _repository.registrarCita(authRequest);

    //_loadingData.sink.add(false);
    if (apiresponse.data != null) {
      debugPrint(apiresponse.data);      
      final snackBar = SnackBar(
        content: Text('Cita Medica Creada correctamente'));
      Scaffold.of(context).showSnackBar(snackBar);
    } else {
      debugPrint('Error');
      final snackBar =
          SnackBar(content: Text('Ocurrio un error Registrando la cita'));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  void dispose() {
    _cedulaController.close();
    _numeroController.close();
    _motivoController.close();
    _fechaController.close();
   // _horaController.close();
    //_loadingData.close();
  }
}