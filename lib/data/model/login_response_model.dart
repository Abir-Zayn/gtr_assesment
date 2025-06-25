import 'package:gtr_assessment/domain/entities/user.dart';

class LoginResponseModel extends User {
  const LoginResponseModel({
    required super.id,
    required super.email,
    required super.name,
    required super.token,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      id: json['Id']?.toString() ?? '',
      email: json['Email'] ?? '',
      name: json['Name'] ?? json['UserName'] ?? '',
      token: json['Token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'Id': id, 'Email': email, 'Name': name, 'Token': token};
  }
}
