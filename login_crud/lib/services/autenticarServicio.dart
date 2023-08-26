import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AutenticarServices extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyCM0vwzGqhfxrsZVvaXP2z-jHlmZ_UqUP0';
  final storage = const FlutterSecureStorage();

  Future<String?> crearUsuario(String email, String password) async {
    final Map<String, dynamic> autData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    final url =
        Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _firebaseToken});

    final resp = await http.post(url, body: json.encode(autData));

    final Map<String, dynamic> respDecode = json.decode(resp.body);

    if (respDecode.containsKey('idToken')) {
      await storage.write(key: 'token', value: respDecode['idToken']);
      return null;
    } else {
      return respDecode['error']['message'];
    }
  }

  Future<String?> validar(String email, String password) async {
    final Map<String, dynamic> autData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    final url = Uri.https(
        _baseUrl, '/v1/accounts:signInWithPassword', {'key': _firebaseToken});

    final resp = await http.post(url, body: json.encode(autData));

    final Map<String, dynamic> respDecode = json.decode(resp.body);

    if (respDecode.containsKey('idToken')) {
      await storage.write(key: 'token', value: respDecode['idToken']);

      //return respDecode['idToken'];
      return null;
    } else {
      return respDecode['error']['message'];
    }
  }

  Future logout() async {
    await storage.delete(key: 'token');

    return;
  }

  Future<String> LeerToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}
