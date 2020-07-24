import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client, Response;

import 'package:travel_planner/models/models.dart';

class SpotProvider {
  final Client client = Client();

  Future<Spot> getSpots() async {
    Response response;

    response = await client.get('https://chargingspotsapi.herokuapp.com/spots');

    if (response.statusCode == 200) {
      print(response.statusCode);
      return Spot.fromJson(json.decode(response.body));
    }

    throw Exception('Error al iniciar sesión');
  }
}
