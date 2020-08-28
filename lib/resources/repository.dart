import 'dart:async';

import 'package:travel_planner/models/models.dart';
import 'package:travel_planner/resources/api/auth_provider.dart';
import 'package:travel_planner/resources/api/spot_provider.dart';
import 'package:travel_planner/resources/api/user_provider.dart';

class Repository {
  final authProvider = AuthProvider();
  final spotProvider = SpotProvider();
  final userProvider = UserProvider();

  // api
  Future<User> loginUser(String email, String password) =>
      authProvider.loginUser(email, password);

  Future<dynamic> registerUser(String name, String email) =>
      userProvider.registerUser(name, email);

  Future<List> getSpots() => spotProvider.getSpots();
}
