import 'package:localstorage/localstorage.dart';

import 'package:travel_planner/core/core.dart';

class StorageProvider {
  final String preferencesKey = 'charging_spots';
  StorageProvider._();

  static final StorageProvider store = StorageProvider._();

  LocalStorage _storage;

  LocalStorage get storage {
    if (_storage != null) {
      return _storage;
    }

    _storage = new LocalStorage(preferencesKey);

    return _storage;
  }

  void setJSONEntity(String key, JSONEntity value) {
    final LocalStorage localStorage = storage;

    localStorage.setItem(key, value.toJSONEncodable());
  }

  dynamic getJSONEntity(String key) {
    final LocalStorage localStorage = storage;

    return localStorage.getItem(key);
  }
}
