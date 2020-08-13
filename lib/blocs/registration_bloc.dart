import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:travel_planner/resources/repository.dart';
import 'package:travel_planner/utils/utils.dart';

class RegistrationBloc with FieldValidators {
  final _repository = Repository();

  // subjects
  final _name$ = BehaviorSubject<String>();
  final _email$ = BehaviorSubject<String>();
  final _loading$ = BehaviorSubject<bool>.seeded(true);

  // state
  get nameValue => _name$.value;
  get emailValue => _email$.value;
  get loading => _loading$.value;

  // streams
  Stream<String> get nameStream => _name$.stream.transform(textValidation);
  Stream<String> get emailStream => _email$.stream.transform(email);

  Stream<bool> get canActivate =>
      Rx.combineLatest2(nameStream, emailStream, (u, e) => true);
  Stream<bool> get loadingStream => _loading$.stream;

  // handlers
  Function(String) get nameChanged => _name$.sink.add;
  Function(String) get emailChanged => _email$.sink.add;

  registerUser() async {
    _loading$.sink.add(true);
    await _repository.registerUser(nameValue, emailValue);
    _loading$.sink.add(false);
  }

  dispose() {
    _name$?.close();
    _email$?.close();
    _loading$?.close();
  }
}
