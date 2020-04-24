import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medicalappfront/src/models/authResponse.dart';

class SessionStorage {
  static final _storage = FlutterSecureStorage();

  Future<Map<String, String>> getAllValues() async {
    return await _storage.readAll();
  }

  Future<String> getValueforKey(String key) async {
    return await _storage.read(key: key);
  }

  Future deleteValue(String key) async {
    await _storage.delete(key: key);
  }

  Future deleteAllValues() async {
    await _storage.deleteAll();
  }

  Future writeValue(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  Future saveSessionStorage(AuthResponse session) async {
    await _storage.write(key: 'accessToken', value: session.accessToken);
    await _storage.write(key: 'id', value: session.id.toString());
  }
}
