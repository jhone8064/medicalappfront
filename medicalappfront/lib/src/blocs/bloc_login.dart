import 'dart:convert';

import 'package:rxdart/rxdart.dart';
import 'package:medicalappfront/src/blocs/authorization_bloc.dart';
import 'package:medicalappfront/src/blocs/validator.dart';
import 'package:medicalappfront/src/models/apiResponse.dart';
import 'package:medicalappfront/src/models/model_user.dart';
import 'package:medicalappfront/src/models/authResponse.dart';
import 'package:medicalappfront/src/resources/repository.dart';
import 'package:flutter/material.dart';

class LoginBloc extends Validators {
  Repository repository = Repository();

  final BehaviorSubject _usernameController = BehaviorSubject<String>();
  final BehaviorSubject _passwordController = BehaviorSubject<String>();
  final PublishSubject _loadingData = PublishSubject<bool>();

  Function(String) get changeUsername => _usernameController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  Stream<String> get username =>
      _usernameController.stream.transform(validateEmail);
  Stream<String> get password =>
      _passwordController.stream.transform(validatePassword);

  Stream<bool> get submitValid =>
      Rx.combineLatest2(username, password, (username, password) => true);
  Stream<bool> get loading => _loadingData.stream;

  void submit(BuildContext context) {
    final validUsername = _usernameController.value;
    final validPassword = _passwordController.value;
    UserData user =
        new UserData(username: validUsername, password: validPassword);
    _loadingData.sink.add(true);
    login(user, context);
  }

  String tok;

  void setToken(String token){
    print("---------------------------------");
    print(token);
    tok = token;
  }

  login(UserData authRequest, BuildContext context) async {
    authRequest.token = tok;
    ApiResponse apiresponse = await repository.login(authRequest);
    print('');
    _loadingData.sink.add(false);
   
    if (apiresponse.data != null) {
      AuthResponse authResponse = AuthResponse.fromJson(jsonDecode(apiresponse.data)['data']);
      if (authResponse.accessToken != null &&
          authResponse.accessToken.length > 0) {
        authBloc.openSession(authResponse);
      }
    } else {
      final snackBar =
          SnackBar(content: Text('Ocurrio un error Validando usuario'));
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }

  void dispose() {
    _usernameController.close();
    _passwordController.close();
    _loadingData.close();
  }
}
