import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:travel_planner/models/models.dart';
import 'package:travel_planner/resources/repository.dart';
import 'package:travel_planner/utils/utils.dart';

class LoginBloc with FieldValidators {
  final _repository = Repository();

  // subjects
  final _email$ = BehaviorSubject<String>();
  final _password$ = BehaviorSubject<String>();
  final _loginUser$ = BehaviorSubject<User>();
  final _loading$ = BehaviorSubject<bool>.seeded(false);

  // state
  get emailValue => _email$.value;
  get passwordValue => _password$.value;
  get userValue => _loginUser$.value;
  get loading => _loading$.value;

  // streams
  Stream<String> get emailStream => _email$.stream.transform(email);
  Stream<String> get pwdStream => _password$.stream.transform(password);
  Stream<bool> get canActivate =>
      Rx.combineLatest2(emailStream, pwdStream, (e, p) => true);
  Stream<User> get loginUserStream => _loginUser$.stream;
  Stream<bool> get loadingStream => _loading$.stream;

  // handlers
  Function(String) get emailChanged => _email$.sink.add;
  Function(String) get passwordChanged => _password$.sink.add;

  loginUser() async {
    _loading$.sink.add(true);

    _loginUser$.sink
        .add(await _repository.loginUser(emailValue, passwordValue));
  }

  dispose() {
    _email$?.close();
    _password$?.close();
    _loginUser$?.close();
    _loading$?.close();
  }
}
