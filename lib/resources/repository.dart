import 'dart:async';

import 'package:travel_planner/models/models.dart';
import 'package:travel_planner/resources/api/auth_provider.dart';
import 'package:travel_planner/resources/api/spot_provider.dart';

class Repository {
  final authProvider = AuthProvider();
  final spotProvider = SpotProvider();

  // api
  Future<User> loginUser(String email, String password) =>
      authProvider.loginUser(email, password);

  Future<Spot> getSpots() => spotProvider.getSpots();
}
