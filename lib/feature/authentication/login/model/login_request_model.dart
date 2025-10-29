class LoginRequestModel {
  String? username;
  String? password;

  LoginRequestModel({this.username, this.password});

  Map<String, dynamic> toMap() => {
    'username': username,
    'password': password,
  };
}

class UserModel {
  final String id;
  final String username;
  final String fullName;
  final String? email;

  UserModel({
    required this.id,
    required this.username,
    required this.fullName,
    this.email,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
    id: map['id'] ?? '',
    username: map['username'] ?? '',
    fullName: map['fullName'] ?? '',
    email: map['email'],
  );
}

