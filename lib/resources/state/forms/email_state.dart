import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:travel_planner/utils/utils.dart';

class EmailStream with FieldValidators {
  EmailStream._();

  static EmailStream _instance;

  factory EmailStream() {
    return _instance ??= new EmailStream._();
  }

  // subjects
  final _email$ = BehaviorSubject<String>();

  // state
  get value => _email$.value;

  // streams
  Stream<String> get stream => _email$.stream.transform(email);

  // handlers
  Function(String) get onChanged => _email$.sink.add;

  dispose() {
    _email$?.close();
  }
}
