import 'package:localstorage/localstorage.dart';

class StorageS {
  final LocalStorage storage = new LocalStorage('travel-app');

  void saveItem(item) {
    storage.setItem('user', item);
  }

  Map<String, dynamic> getItem(item) {
    return storage.getItem(item);
  }
}
