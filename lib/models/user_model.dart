class User {
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
}
