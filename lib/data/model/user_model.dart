class UserModel {
  final String email;
  final String name;
  final String role;

  UserModel({
    required this.email,
    required this.name,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      name: json['name'],
      role: json['role'],
    );
  }
}
