import 'package:flutter/foundation.dart';
import 'package:medicalappfront/src/models/model_regiscita.dart';
import 'package:medicalappfront/src/ui/ui_login.dart';
import 'package:rxdart/rxdart.dart';
import 'package:medicalappfront/src/blocs/validator.dart';
import 'package:medicalappfront/src/models/apiResponse.dart';
import 'package:medicalappfront/src/resources/repository.dart';
import 'package:flutter/material.dart';

class RegistrarCitaBloc extends Validators {
  Repository repository = Repository();

  final BehaviorSubject _cedulaController = BehaviorSubject<String>();
  final BehaviorSubject _telefonoController = BehaviorSubject<String>();
  final BehaviorSubject _motivoController = BehaviorSubject<String>();
  
  //final PublishSubject _loadingData = PublishSubject<bool>();

  Function(String) get changeCedula => _cedulaController.sink.add;
  Function(String) get changeTelefono => _telefonoController.sink.add;
  Function(String) get changeMotivo => _motivoController.sink.add;

  Stream<String> get cedula =>
      _cedulaController.stream.transform(validateCedula);
  Stream<String> get telefono =>
      _telefonoController.stream.transform(validateNombres);
  Stream<String> get motivo =>
      _motivoController.stream.transform(validateApellidos);
  
  Stream<bool> get submitValid => Rx.combineLatest3(
      cedula,
      telefono,
      motivo,
      (cedula, telefono, motivo) => true);

  //Stream<bool> get loading => _loadingData.stream;

  void submit(BuildContext context) {
    final validCedula = _cedulaController.value;
    final validTelefono = _telefonoController.value;
    final validMotivo = _motivoController.value;
  

    UserRegisCita user = new UserRegisCita(
        cedula: validCedula,
        telefono: validTelefono,
        motivo: validMotivo
        );
    //_loadingData.sink.add(true);
    registrarCita(user, context);
  }

  registrarCita(UserRegisCita authRequest, BuildContext context) async {
    ApiResponse apiresponse = await repository.registrarCita(authRequest);

    //_loadingData.sink.add(false);
    if (apiresponse.data != null) {
      debugPrint(apiresponse.data);
      /*AuthResponse authResponse =
          AuthResponse.fromJson(jsonDecode(apiresponse.data));
      if (authResponse.accessToken != null &&
          authResponse.accessToken.length > 0) {
        authBloc.openSession(authResponse);
      }*/
      final snackBar = SnackBar(
        content: Text('Cita Medica Creada correctamente'),
        action: SnackBarAction(
          label: 'Aceptar',          
          onPressed: () {
            Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
          },
        ),
      );

      Scaffold.of(context).showSnackBar(snackBar);

    } else {
      debugPrint('Error');
      final snackBar =
          SnackBar(content: Text('Ocurrio un error Registrando usuario'));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  void dispose() {
    _cedulaController.close();
    _telefonoController.close();
    _motivoController.close();
    //_loadingData.close();
  }
}