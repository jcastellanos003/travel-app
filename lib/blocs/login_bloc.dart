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
  final passwordState = StateProvider.getPasswordStreamInstance();

  // subjects
  final _loginUser$ = BehaviorSubject<User>();
  final _loading$ = BehaviorSubject<bool>.seeded(false);
  // ignore: close_sinks
  final _error$ = BehaviorSubject<String>.seeded(null);

  // state
  get userValue => _loginUser$.value;
  get loading => _loading$.value;
  get error$ => _error$.value;

  // streams
  Stream<bool> get canActivate => Rx.combineLatest2(
      emailState.stream, passwordState.stream, (e, p) => true);
  Stream<User> get loginUserStream => _loginUser$.stream;
  Stream<bool> get loadingStream => _loading$.stream;
  Stream<String> get errorStream => _error$.stream;

  loginUser() async {
    _loading$.sink.add(true);
    try {
      Map response =
          await _repository.loginUser(emailState.value, passwordState.value);

      if (response['status'] == false) {
        _error$.sink.add(response['message']);
      } else {
        User user = User.fromJson(response);

        // set store
        StorageProvider.store.setJSONEntity('user', user);

        print(StorageProvider.store.getJSONEntity('user'));

        _loginUser$.sink.add(user);
      }
      _loading$.sink.add(false);
    } catch (e) {
      print(e.message);
      _error$.sink.add(e.message);
    }
  }

  dispose() {
    _error$?.close();
    _loginUser$?.close();
    _loading$?.close();
  }
}
