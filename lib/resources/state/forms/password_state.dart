import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:travel_planner/utils/utils.dart';

class PasswordStream with FieldValidators {
  PasswordStream._();

  static PasswordStream _instance;

  factory PasswordStream() {
    return _instance ??= new PasswordStream._();
  }

  // subjects
  final _password$ = BehaviorSubject<String>();

  // state
  get value => _password$.value;

  // streams
  Stream<String> get stream => _password$.stream.transform(password);

  // handlers
  Function(String) get onChanged => _password$.sink.add;

  dispose() {
    _password$?.close();
  }
}
