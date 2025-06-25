import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:gtr_assessment/domain/entities/login_request.dart';
import 'package:gtr_assessment/domain/entities/user.dart';
import 'package:gtr_assessment/domain/usecase/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final LoginUsecase loginUsecase;

  LoginCubit({required this.loginUsecase}) : super(LoginInitial());

  Future<void> login({
    required String email,
    required String password,
    int comId = 1,
  }) async {
    emit(LoginLoading());

    final response = LoginRequest(
      userEmail: email,
      password: password,
      comId: comId,
    );

    final result = await loginUsecase(response);

    result.fold(
      (failure) => emit(LoginFailure(failure)),
      (user) => emit(LoginSuccess(user)),
    );
  }

  void resetState() {
    emit(LoginInitial());
  }
}
