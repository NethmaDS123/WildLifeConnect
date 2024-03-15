import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();

  static Future<void> storeToken(String token) async {
    await _storage.write(key: 'jwt_token', value: token);
  }

  static Future<String?> getToken() async {
    return await _storage.read(key: 'jwt_token');
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: 'jwt_token');
  }

  static Future storeName(String firstName, String lastName) async {
    await _storage.write(key: 'firstName', value: firstName);
    await _storage.write(key: 'lastName', value: lastName);
  }

  static Future storeEmail(String email) async {
    await _storage.write(key: 'email', value: email);
  }

  static Future<String?> getFirstName() async {
    return await _storage.read(key: 'firstName');
  }

  static Future<String?> getLastName() async {
    return await _storage.read(key: 'lastName');
  }

  static Future<String?> getEmail() async {
    return await _storage.read(key: 'email');
  }
}
