import 'package:rxdart/rxdart.dart';
import 'package:medicalappfront/src/blocs/session_storage.dart';
import 'package:medicalappfront/src/models/authResponse.dart';

class AuthorizationBloc {
  SessionStorage sessionStorage = SessionStorage();
  String _tokenString = "";
  String _id = "";
  final PublishSubject _isSessionValid = PublishSubject<bool>();
  Stream<bool> get isSessionValid => _isSessionValid.stream;
  void dispose() {
    _isSessionValid.close();
  }

  void restoreSession() async {
    _tokenString = await sessionStorage.getValueforKey("accessToken");
    if ((_tokenString != null && _tokenString.length > 0)) {
      _isSessionValid.sink.add(true);
    } else {
      _isSessionValid.sink.add(false);
    }
  }

  void openSession(AuthResponse authResponse) async {
    sessionStorage.saveSessionStorage(authResponse);
    _isSessionValid.sink.add(true);
  }

  void closeSession() async {
    await sessionStorage.deleteAllValues();
    _isSessionValid.sink.add(false);
  }

  Future<bool> validateSesion() async {
    _tokenString = await sessionStorage.getValueforKey("accessToken");
    return ((_tokenString != null && _tokenString.length > 0));
  }

  Future<String> getToken() async {
    _tokenString = await sessionStorage.getValueforKey("accessToken");
    return _tokenString;
  }

  Future<String> getId() async {
    _id = await sessionStorage.getValueforKey("id");
    return _id;
  }
}

final authBloc = AuthorizationBloc();
