import 'package:dartz/dartz.dart';
import 'package:gtr_assessment/domain/entities/login_request.dart';
import 'package:gtr_assessment/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<String, User>> login(LoginRequest request);
}
