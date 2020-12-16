import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chatapp/src/models/usuario.dart';
import 'package:chatapp/global/environment.dart';
import 'package:chatapp/src/models/login_response.dart';

class AuthService with ChangeNotifier {
  Usuario _usuario;
  bool _autenticando = false;

// Get del Usuario

  Usuario get usuario=>_usuario;
// Create storage
  final _storage = new FlutterSecureStorage();

  bool get autenticando => this._autenticando;
  set autenticando(bool valor) {
    this._autenticando = valor;
    notifyListeners();
  }

// OBTENGO EL TOKEN  DE MANERA STATIC

  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage();
    // Read value
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage();
    // delete value
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    this.autenticando = true;

    final data = {
      'email': email,
      'password': password,
    };

    final resp = await http
        .post('${Environments.apiUrl}/login', body: jsonEncode(data), headers: {
      'Content-Type': 'application/json',
    });

    print(resp.body);
    this.autenticando = false;

    if (resp.statusCode == 200) {
      final decodedData = loginResponseFromJson(resp.body);
      this._usuario = decodedData.usuario;
      await this._guardarToken(decodedData.token);
      return true;
    } else {
      return false;
    }
  }

  Future _guardarToken(String token) async {
// Write value
    await _storage.write(key: 'token', value: token);
  }

  Future logout() async {
// Delete value
    await _storage.delete(key: 'token');
  }

  Future register(String nombre, String email, String password) async {
    this.autenticando = true;

    final data = {
      'nombre': nombre,
      'email': email,
      'password': password,
    };

    final resp = await http.post('${Environments.apiUrl}/login/new',
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
        });

    this.autenticando = false;

    if (resp.statusCode == 200) {
      final decodedData = loginResponseFromJson(resp.body);
      this._usuario = decodedData.usuario;
      await this._guardarToken(decodedData.token);
      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await this._storage.read(key: 'token');

    final resp = await http.get('${Environments.apiUrl}/login/renew', headers: {
      'Content-Type': 'application/json',
      'x-token': token,
    });

    if (resp.statusCode == 200) {
      final decodedData = loginResponseFromJson(resp.body);
      this._usuario = decodedData.usuario;
      await this._guardarToken(decodedData.token);
      return true;
    } else {
      this.logout();
      return false;
    }
  }
}
