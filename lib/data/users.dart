// ignore_for_file: non_constant_identifier_names

class User {
  String id;
  String email;
  String first_name;
  String last_name;
  String avatar;

  User(
      {required this.id,
      required this.first_name,
      required this.last_name,
      required this.avatar,
      required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"] as String,
      first_name: json["first_name"] as String,
      last_name: json["last_name"] as String,
      email: json["email"] as String,
      avatar: json["avatar"] as String,
    );
  }
}
