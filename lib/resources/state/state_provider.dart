import 'package:travel_planner/resources/state/forms/email_state.dart';

class StateProvider {
  StateProvider._();

  static StateProvider _instance;

  factory StateProvider() {
    return _instance ??= new StateProvider._();
  }

  static EmailStream getEmailStreamInstance() {
    return EmailStream();
  }
}
