import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:travel_planner/models/models.dart';
import 'package:travel_planner/resources/core/core.dart';
import 'package:travel_planner/resources/repository.dart';
import 'package:travel_planner/utils/utils.dart';

class RegistrationBloc with FieldValidators {
  final _repository = Repository();

  // subjects
  final _name$ = BehaviorSubject<String>();
  final _email$ = BehaviorSubject<String>();
  final _loginUser$ = BehaviorSubject<User>();
  final _loading$ = BehaviorSubject<bool>.seeded(false);

  // state
  get nameValue => _name$.value;
  get emailValue => _email$.value;
  get userValue => _loginUser$.value;
  get loading => _loading$.value;

  // streams
  Stream<String> get nameStream => _name$.stream.transform(textValidation);
  Stream<String> get emailStream => _email$.stream.transform(email);

  Stream<bool> get canActivate =>
      Rx.combineLatest2(nameStream, emailStream, (u, e) => true);
  Stream<User> get loginUserStream => _loginUser$.stream;
  Stream<bool> get loadingStream => _loading$.stream;

  // handlers
  Function(String) get nameChanged => _name$.sink.add;
  Function(String) get emailChanged => _email$.sink.add;

  registerUser() async {
    dynamic emailMessage =
        await _repository.registerUser(nameValue, emailValue);

    print('registering $emailMessage');
  }

  dispose() {
    _name$?.close();
    _email$?.close();
    _loginUser$?.close();
    _loading$?.close();
  }
}
