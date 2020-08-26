import 'dart:async';
import 'request.dart';

class AuthProvider {
  Future<Map> loginUser(String email, String password) async {
    Request request = new Request();

    dynamic response = await request.requestBuilder(
        'post', '/auth/signIn', {email: email, password: password});

    return response;
  }
}
