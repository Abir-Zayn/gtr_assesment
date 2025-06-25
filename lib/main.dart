import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtr_assessment/common/bloc/theme_cubit.dart';
import 'package:gtr_assessment/core/navigation/app_router_imports.dart';
import 'package:gtr_assessment/data/repository/auth_repo_implementation.dart';
import 'package:gtr_assessment/data/src/auth_data_src.dart';
import 'package:gtr_assessment/domain/repositories/auth_repository.dart';
import 'package:gtr_assessment/domain/usecase/login_usecase.dart';
import 'package:gtr_assessment/presentation/auth/cubit/login_cubit.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MainApp());
}

void applyTheme() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
  );
}

class MainApp extends StatelessWidget {
  final http.Client httpClient = http.Client();
  late final AuthDataSrc authDataSrc;
  late final AuthRepository authRepository;
  late final LoginUsecase loginUsecase;

  MainApp({super.key}) {
    authDataSrc = AuthRemoteDataSrcImpl(client: httpClient);

    authRepository = AuthRepoImplementation(dataSrc: authDataSrc);

    loginUsecase = LoginUsecase(repo: authRepository);
  }

  // Dependency injection

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Theme BlocProvider
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => LoginCubit(loginUsecase: loginUsecase)),
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, theme) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: theme,
            routerConfig: appRouter,
          );
        },
      ),
    );
  }
}
