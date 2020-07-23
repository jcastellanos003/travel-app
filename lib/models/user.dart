class User {
  final String email;
  final String password;

  const User({this.email, this.password});

  @override
  String toString() => 'User {email: $email}';
}
