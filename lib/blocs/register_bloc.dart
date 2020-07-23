import 'dart:async';
import 'package:rxdart/rxdart.dart';

import '../utils/utils.dart';
import 'package:travel_planner/models/models.dart';

class RegisterBloc with FieldValidators {
  // subjects
  final _email$ = BehaviorSubject<String>();
  final _password$ = BehaviorSubject<String>();

  // state
  get userState => new User(email: _email$.value, password: _password$.value);

  // streams
  Stream<String> get emailStream => _email$.stream.transform(email);
  Stream<String> get pwdStream => _password$.stream.transform(password);
  Stream<bool> get registerStream =>
      Rx.combineLatest2(emailStream, pwdStream, (e, p) => true);

  // handlers
  Function(String) get emailChanged => _email$.sink.add;
  Function(String) get passwordChanged => _password$.sink.add;

  dispose() {
    _email$?.close();
    _password$?.close();
  }
}
