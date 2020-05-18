import 'package:rxdart/rxdart.dart';
import 'package:medicalappfront/src/blocs/authorization_bloc.dart';
import 'package:medicalappfront/src/models/citasList.dart';
import 'package:medicalappfront/src/resources/repository.dart';
//import 'package:flutter/foundation.dart';

class CitasBloc {
  final _repository = Repository();
  final _cita = PublishSubject<CitasList>();

  Stream<CitasList> get infoCitas => _cita.stream;

  getInfoCitas() async {
    String accesToken = await authBloc.getId();    
    CitasList cita = await _repository.fetchAllCitas(accesToken);
    _cita.sink.add(cita);    
    return cita;
  }

  dispose() {
    _cita.close();
  }
}

final citasBloc = CitasBloc();