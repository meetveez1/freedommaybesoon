import 'app_enums.dart';

class AppUser {
  const AppUser({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.role,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final UserRole role;

  String get fullName => '$firstName $lastName';

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'role': role.name,
      };

  factory AppUser.fromJson(Map<String, dynamic> json) => AppUser(
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        email: json['email'] as String,
        password: json['password'] as String,
        role: UserRole.values.byName(json['role'] as String),
      );
}
