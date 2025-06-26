import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtr_assessment/common/bloc/theme_cubit.dart';
import 'package:gtr_assessment/core/navigation/app_router_imports.dart';
import 'package:gtr_assessment/data/repository/auth_repo_implementation.dart';
import 'package:gtr_assessment/data/repository/customer_repository_impl.dart';
import 'package:gtr_assessment/data/src/auth_data_src.dart';
import 'package:gtr_assessment/data/src/customer_data_src.dart';
import 'package:gtr_assessment/domain/repositories/auth_repository.dart';
import 'package:gtr_assessment/domain/repositories/customer_repository.dart';
import 'package:gtr_assessment/domain/usecase/customer_list_usecase.dart';
import 'package:gtr_assessment/domain/usecase/login_usecase.dart';
import 'package:gtr_assessment/presentation/auth/cubit/login_cubit.dart';
import 'package:gtr_assessment/presentation/homePage/cubit/customer_cubit.dart';
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

  //Login Usecase and Repository [ Dependency Injection ]
  late final AuthDataSrc authDataSrc;
  late final AuthRepository authRepository;
  late final LoginUsecase loginUsecase;

  // Customer Usecase and Repository [ Dependency Injection ]
  late final CustomerDataSrc customerDataSrc;
  late final CustomerRepository customerRepository;
  late final CustomerListUsecase customerListUsecase;

  MainApp({super.key}) {
    authDataSrc = AuthRemoteDataSrcImpl(client: httpClient);
    authRepository = AuthRepoImplementation(dataSrc: authDataSrc);
    loginUsecase = LoginUsecase(repo: authRepository);

    // customer dependency injection
    customerDataSrc = CustomerDataSrcImpl(client: httpClient);
    customerRepository = CustomerRepositoryImpl(dataSrc: customerDataSrc);
    customerListUsecase = CustomerListUsecase(customerRepository);
  }

  // Dependency injection

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Theme BlocProvider
        BlocProvider(create: (_) => ThemeCubit()),
        BlocProvider(create: (_) => LoginCubit(loginUsecase: loginUsecase)),
        BlocProvider(create: (_) => CustomerCubit(customerListUsecase)),
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
