import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:travel_planner/models/models.dart';
import 'package:travel_planner/resources/repository.dart';
import 'package:travel_planner/resources/resources.dart';
import 'package:travel_planner/resources/state/state.dart';
import 'package:travel_planner/utils/utils.dart';

class LoginBloc with FieldValidators {
  final _repository = Repository();
  final emailState = StateProvider.getEmailStreamInstance();

  // subjects
  final _password$ = BehaviorSubject<String>();
  final _loginUser$ = BehaviorSubject<User>();
  final _loading$ = BehaviorSubject<bool>.seeded(false);

  // state
  get passwordValue => _password$.value;
  get userValue => _loginUser$.value;
  get loading => _loading$.value;

  // streams
  Stream<String> get pwdStream => _password$.stream.transform(password);
  Stream<bool> get canActivate =>
      Rx.combineLatest2(emailState.stream, pwdStream, (e, p) => true);
  Stream<User> get loginUserStream => _loginUser$.stream;
  Stream<bool> get loadingStream => _loading$.stream;

  // handlers
  Function(String) get passwordChanged => _password$.sink.add;

  loginUser() async {
    User user = await _repository.loginUser(emailState.value, passwordValue);

    // set store
    StorageProvider.store.setJSONEntity('user', user);

    print(StorageProvider.store.getJSONEntity('user'));

    _loading$.sink.add(true);
    _loginUser$.sink.add(user);
  }

  dispose() {
    _password$?.close();
    _loginUser$?.close();
    _loading$?.close();
  }
}
