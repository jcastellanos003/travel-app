import 'dart:async';
import 'request.dart';
import 'package:travel_planner/models/user_model.dart';

class AuthProvider {
  Future<User> loginUser(String email, String password) async {
    Request request = new Request();

    Map response = await request.requestBuilder(
        'post', '/auth/signIn', {"email": email, "password": password});

    return User.fromJson(response);
  }
}
