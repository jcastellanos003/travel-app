import 'dart:async';

import 'package:travel_planner/models/models.dart';
import 'package:travel_planner/resources/api/auth_provider.dart';

class Repository {
  final authProvider = AuthProvider();

  Future<User> loginUser(String email, String password) =>
      authProvider.loginUser(email, password);
}
