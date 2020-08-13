import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client, Response;
import 'package:http_interceptor/http_interceptor.dart';

class Request {
  String baseUrl = 'https://chargingspotsapi.herokuapp.com';

  Future<dynamic> requestBuilder(String method, String path,
      Map<String, String> data, List<InterceptorContract> interceptors) async {
    Client client = HttpClientWithInterceptor.build(interceptors: interceptors);

    Map<String, dynamic> methodMap = {
      "post": client.post,
      "get": client.get,
      "put": client.put
    };

    Response response = await methodMap[method]('$baseUrl$path',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(data));

    // Base case
    if (response.statusCode == 200) {
      Map data = json.decode(response.body);
      if (data['status'] == true) {
        //Success notification
        print('success');
      } else {
        //Error notification
        print('error');
      }

      return data;
    }

    //Network Errors

    //Server Errors

    throw Exception('Error al crear usuario');
  }
}
