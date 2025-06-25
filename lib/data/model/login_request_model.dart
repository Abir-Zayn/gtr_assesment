import 'package:gtr_assessment/domain/entities/login_request.dart';

class LoginRequestModel extends LoginRequest {
  const LoginRequestModel({
    required super.userEmail,
    required super.password,
    required super.comId,
  });

  Map<String, dynamic> toJson() {
    return {'UserName': userEmail, 'Password': password, 'ComId': comId};
  }

  String queryString() {
    return 'UserName=$userEmail&Password=$password&ComId=$comId';
  }
}
