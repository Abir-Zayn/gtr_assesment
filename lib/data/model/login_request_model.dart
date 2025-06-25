import 'package:gtr_assessment/domain/entities/login_request.dart';

class LoginRequestModel extends LoginRequest {
  const LoginRequestModel({
    required super.userName,
    required super.password,
    required super.comId,
  });

  Map<String, dynamic> toJson() {
    return {'UserName': userName, 'Password': password, 'ComId': comId};
  }

  String queryString() {
    return 'UserName=$userName&Password=$password&ComId=$comId';
  }
}
