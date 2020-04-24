import 'package:flutter/foundation.dart';
import 'package:medicalappfront/src/ui/ui_login.dart';
import 'package:rxdart/rxdart.dart';
import 'package:medicalappfront/src/blocs/validator.dart';
import 'package:medicalappfront/src/models/apiResponse.dart';
import 'package:medicalappfront/src/models/model_regis.dart';
import 'package:medicalappfront/src/resources/repository.dart';
import 'package:flutter/material.dart';

class RegistrarBloc extends Validators {
  Repository repository = Repository();

  final BehaviorSubject _cedulaController = BehaviorSubject<String>();
  final BehaviorSubject _nombresController = BehaviorSubject<String>();
  final BehaviorSubject _apellidosController = BehaviorSubject<String>();
  final BehaviorSubject _usernameController = BehaviorSubject<String>();
  final BehaviorSubject _passwordController = BehaviorSubject<String>();
  //final PublishSubject _loadingData = PublishSubject<bool>();

  Function(String) get changeCedula => _cedulaController.sink.add;
  Function(String) get changeNombre => _nombresController.sink.add;
  Function(String) get changeApellidos => _apellidosController.sink.add;
  Function(String) get changeUsername => _usernameController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  Stream<String> get cedula =>
      _cedulaController.stream.transform(validateCedula);
  Stream<String> get nombres =>
      _nombresController.stream.transform(validateNombres);
  Stream<String> get apellidos =>
      _apellidosController.stream.transform(validateApellidos);
  Stream<String> get username =>
      _usernameController.stream.transform(validateEmail);
  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);

  Stream<bool> get submitValid => Rx.combineLatest5(
      cedula,
      nombres,
      apellidos,
      username,
      password,
      (cedula, nombres, apellidos, username, password) => true);

  //Stream<bool> get loading => _loadingData.stream;

  void submit(BuildContext context) {
    final validCedula = _cedulaController.value;
    final validNombres = _nombresController.value;
    final validApellidos = _apellidosController.value;
    final validUsername = _usernameController.value;
    final validPassword = _passwordController.value;

    UserRegisData user = new UserRegisData(
        cedula: validCedula,
        nombres: validNombres,
        apellidos: validApellidos,
        username: validUsername,
        password: validPassword);
    //_loadingData.sink.add(true);
    registrar(user, context);
  }

  registrar(UserRegisData authRequest, BuildContext context) async {
    ApiResponse apiresponse = await repository.registrar(authRequest);

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
        content: Text('Usuario Creado correctamente'),
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
    _nombresController.close();
    _apellidosController.close();
    _usernameController.close();
    _passwordController.close();
    //_loadingData.close();
  }
}
