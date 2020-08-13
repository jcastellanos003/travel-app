import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client, Response;
import 'package:http_interceptor/http_interceptor.dart';
import 'interceptors.dart';

class UserProvider {
  //final Client client = Client();

  Client client = HttpClientWithInterceptor.build(interceptors: [
    GeneralInterceptor(),
  ]);

  Future<dynamic> registerUser(String name, String email) async {
    Response response;

    response = await client.post(
        'https://chargingspotsapi.herokuapp.com/users/verify',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(<String, String>{'name': name, 'email': email}));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    }

    throw Exception('Error al crear usuario');
  }
}
