import 'package:dartz/dartz.dart';
import 'package:gtr_assessment/data/model/login_request_model.dart';
import 'package:gtr_assessment/data/src/auth_data_src.dart';
import 'package:gtr_assessment/domain/entities/login_request.dart'
    show LoginRequest;
import 'package:gtr_assessment/domain/entities/user.dart';
import 'package:gtr_assessment/domain/repositories/auth_repository.dart';

class AuthRepoImplementation implements AuthRepository {
  final AuthDataSrc dataSrc;

  AuthRepoImplementation({required this.dataSrc});
  @override
  Future<Either<String, User>> login(LoginRequest request) async {
    try {
      final response = LoginRequestModel(
        userEmail: request.userEmail,
        password: request.password,
        comId: request.comId,
      );
      final loginResponse = await dataSrc.login(response);
      return Right(loginResponse);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
