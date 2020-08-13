import 'dart:async';
import 'interceptors.dart';
import 'request.dart';

class UserProvider {
  Future<dynamic> registerUser(String name, String email) async {
    Request request = new Request();

    dynamic response = await request.requestBuilder('post', '/users/verify',
        {name: name, email: email}, [GeneralInterceptor()]);

    return response;
  }
}
