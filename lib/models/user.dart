class User {
  final String id;
  final String name;
  final String email;
  final String avatar;

  User({this.id, this.name, this.email, this.avatar});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['user._id'],
        name: json['user.name'],
        email: json['user.email'],
        avatar: json['user.avatar']);
  }
}
