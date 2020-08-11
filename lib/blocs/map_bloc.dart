import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:travel_planner/models/models.dart';
import 'package:travel_planner/resources/repository.dart';
import 'package:travel_planner/utils/utils.dart';

class MapBloc with FieldValidators {
  final _repository = Repository();

  // subjects
  final _spots$ = BehaviorSubject<List>.seeded([]);
  final _loading$ = BehaviorSubject<bool>.seeded(false);

  // state
  get spotsValue => _spots$.value;
  get loading => _loading$.value;

  // streams
  Stream<List> get spotsStream => _spots$.stream;
  Stream<bool> get loadingStream => _loading$.stream;

  loadSpots() async {
    _loading$.sink.add(true);
    _spots$.sink.add(await _repository.getSpots());
  }

  dispose() {
    _spots$?.close();
    _loading$?.close();
  }
}
