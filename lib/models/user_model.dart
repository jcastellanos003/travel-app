import 'package:travel_planner/core/core.dart';

class User implements JSONEntity {
  final String id;
  final String name;
  final String email;
  final String avatar;

  User({this.id, this.name, this.email, this.avatar});

  factory User.fromJson(Map<String, dynamic> json) {
    dynamic raw = json['user'];

    return User(
        id: raw['_id'],
        name: raw['name'],
        email: raw['email'],
        avatar: raw['avatar']);
  }

  Map<String, dynamic> toJSONEncodable() {
    Map<String, dynamic> encodedObject = new Map();

    encodedObject['id'] = id;
    encodedObject['name'] = name;
    encodedObject['email'] = email;
    encodedObject['avatar'] = avatar;

    return encodedObject;
  }
}
