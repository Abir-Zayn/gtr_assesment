import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gtr_assessment/common/theme/app_theme.dart';

class ThemeCubit extends Cubit<ThemeData> {
  ThemeCubit() : super(lightTheme);

  void toggleTheme() {
    // Emit the opposite theme based on the current state
    emit(state.brightness == Brightness.light ? darkTheme : lightTheme);
  }
}
