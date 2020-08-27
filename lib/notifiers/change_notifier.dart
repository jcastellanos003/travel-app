import 'package:flutter/material.dart';
import 'package:travel_planner/models/user_model.dart';
import 'package:travel_planner/notifiers/failure.dart';
import 'package:travel_planner/resources/api/auth_provider.dart';
import 'package:dartz/dartz.dart';

enum NotifierState { initial, loading, loaded }

class GeneralChangeNotifier extends ChangeNotifier {
  final _repository = AuthProvider();

  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;
  void _setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  Either<Failure, User> _user;
  Either<Failure, User> get user => _user;
  void _setUser(Either<Failure, User> user) {
    _user = user;
    notifyListeners();
  }

  /* Failure _failure;
  Failure get failure => _failure;
  void _setFailure(Failure failure) {
    _failure = failure;
    notifyListeners();
  } */

  void login(String email, String password) async {
    _setState(NotifierState.loading);
    try {
      final user = await _repository.loginUser(email, password);
      _setUser(User.fromJson(user));
    } on Failure catch (f) {
      _setFailure(f);
    }

    _setState(NotifierState.loaded);
  }
}
