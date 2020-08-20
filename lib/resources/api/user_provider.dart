import 'dart:async';
import 'request.dart';

class UserProvider {
  Future<dynamic> registerUser(String name, String email) async {
    Request request = new Request();

    dynamic response = await request
        .requestBuilder('post', '/users/verify', {name: name, email: email});

    return response;
  }
}
