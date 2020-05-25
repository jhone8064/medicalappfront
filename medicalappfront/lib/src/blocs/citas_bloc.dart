import 'package:rxdart/rxdart.dart';
import 'package:medicalappfront/src/blocs/authorization_bloc.dart';
import 'package:medicalappfront/src/models/citasList.dart';
import 'package:medicalappfront/src/resources/repository.dart';
import 'package:medicalappfront/src/models/model_regiscita.dart';
import 'package:medicalappfront/src/models/apiResponse.dart';
import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:flutter/foundation.dart';

class CitasBloc {
  final _repository = Repository();
  final _cita = PublishSubject<CitasList>();

  Stream<CitasList> get infoCitas => _cita.stream;

  getInfoCitas() async {
    String accesToken = await authBloc.getId();
    CitasList cita = await _repository.fetchAllCitas(accesToken);
    _cita.sink.add(cita);
  }

  void cancelarCita(BuildContext context, UserRegisCita cita) async {    
    cita.estado = 0;
    ApiResponse apiresponse = await _repository.cancelarCita(cita);    
    if (apiresponse.data != null) {
      final snackBar =
          SnackBar(content: Text('Cita Medica Cancelada correctamente'));
      Scaffold.of(context).showSnackBar(snackBar);
      Navigator.of(context).pop();
    } else {
      debugPrint('Error');
      final snackBar =
          SnackBar(content: Text('Ocurrio un error Registrando la cita'));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  dispose() {
    _cita.close();
  }
}

final citasBloc = CitasBloc();
