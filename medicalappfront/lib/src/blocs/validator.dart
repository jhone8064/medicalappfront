import 'dart:async';

class Validators {
  final validateEmail = StreamTransformer<String, String>.fromHandlers(
      handleData: (username, skin) {
    if (username.contains("@")) {
      skin.add(username);
    } else {
      skin.addError("Error al ingresar el email.");
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, skin) {
    if (password.length > 5 && password.length < 40) {
      skin.add(password);
    } else {
      skin.addError("Error al ingresar el password.");
    }
  });

  final validateCedula = StreamTransformer<String, String>.fromHandlers(
      handleData: (cedula, skin) {
    if (cedula.length > 0) {
      skin.add(cedula);
    } else {
      skin.addError("Error al ingresar La cedula.");
    }
  });

  final validateNombres = StreamTransformer<String, String>.fromHandlers(
      handleData: (nombres, skin) {
    if (nombres.length > 0) {
      skin.add(nombres);
    } else {
      skin.addError("Error al ingresar Los Nombres.");
    }
  });

  final validateApellidos = StreamTransformer<String, String>.fromHandlers(
      handleData: (apellidos, skin) {
    if (apellidos.length > 0) {
      skin.add(apellidos);
    } else {
      skin.addError("Error al ingresar Los Apellidos.");
    }
  });

}
