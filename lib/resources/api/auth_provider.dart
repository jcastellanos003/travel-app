import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client, Response;

import 'package:travel_planner/models/models.dart';

class AuthProvider {
  final Client client = Client();
  final _baseUrl = 'https://chargingspotsapi.herokuapp.com/';

  Future<User> loginUser(String email, String password) async {
    Response response;

    response = await client.post(
        'https://chargingspotsapi.herokuapp.com/auth/signIn',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body:
            jsonEncode(<String, String>{'email': email, 'password': password}));

    if (response.statusCode == 200) {
      print(response.statusCode);
      return User.fromJson(json.decode(response.body));
    }

    if (response.statusCode == 401) {
      print(response.statusCode);
      return User();
    }

    throw Exception('Error al iniciar sesión');
  }
}
