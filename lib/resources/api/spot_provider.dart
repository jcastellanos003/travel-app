import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' show Client, Response;

import 'package:travel_planner/models/models.dart';

class SpotProvider {
  final Client client = Client();

  Future<List<Spot>> getSpots() async {
    Response response;

    response = await client.get('https://chargingspotsapi.herokuapp.com/spots');

    if (response.statusCode == 200) {
      List spots = json.decode(response.body) as List;
      return spots.map((spot) {
        return Spot.fromJson(spot);
      }).toList();
    }

    throw Exception('Error al iniciar mapa');
  }
}
