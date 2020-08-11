import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesProvider {
  PreferencesProvider._();

  static final PreferencesProvider prefs = PreferencesProvider._();
  SharedPreferences _preferences;

  Future<SharedPreferences> get preferences async {
    if (_preferences != null) {
      return _preferences;
    }

    _preferences = await SharedPreferences.getInstance();

    return _preferences;
  }

  Future<void> setInt(String key, int value) async {
    final SharedPreferences pref = await preferences;

    pref.setInt(key, value);
  }
}
