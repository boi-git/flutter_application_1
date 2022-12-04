// ignore: file_names
class Users {
  final String email;
  final String password;
  final String role;
  final String username;

  Users(
      {required this.email,
      required this.password,
      required this.role,
      required this.username});

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'role': role,
        'username': username
      };

  static Users fromJson(Map<String, dynamic> json) => Users(
      email: json['email'],
      password: json['password'],
      role: json['role'],
      username: json['username']);
}
