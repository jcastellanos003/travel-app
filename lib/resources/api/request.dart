import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client, Response;
import 'package:travel_planner/notifiers/failure.dart';

class Request {
  String baseUrl = 'https://chargingspotsapi.herokuapp.com';

  Future<dynamic> requestBuilder(String method, String path,
      [Map<String, dynamic> data]) async {
    Client client = new Client();

    Map<String, dynamic> methodMap = {
      "post": client.post,
      "get": client.get,
      "put": client.put
    };

    Response response = await methodMap[method]('$baseUrl$path',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(data ?? {}));

    if (response.statusCode == 200) {
      Map data = json.decode(response.body);
      print(response);
      if (data['key'] != null) {
        //Success notification
        print('success');
      } else {
        //Error notification
        print('error');
        throw Failure(response.body);
      }

      return data;
    }

    throw Failure(response.body);

    /*  Response response = await methodMap[method]('$baseUrl$path',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: jsonEncode(data ?? {}));

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
    throw Exception(response.body); */
  }
}
