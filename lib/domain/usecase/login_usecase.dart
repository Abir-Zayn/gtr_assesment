import 'package:dartz/dartz.dart';
import 'package:gtr_assessment/domain/entities/login_request.dart';
import 'package:gtr_assessment/domain/entities/user.dart';
import 'package:gtr_assessment/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository repo;
  const LoginUsecase({required this.repo});

  Future<Either<String, User>> call(LoginRequest req) async {
    return await repo.login(req);
  }
}