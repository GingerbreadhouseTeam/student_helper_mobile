import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:student_helper/common/utils/themes/app_theme.dart';

import '../../../utils/themes/dark_theme.dart';

part 'theme_controller.g.dart';

final _darkColors = DarkColors();

sealed class CustomTheme {
  final CustomColors colors;
  final CustomTextTheme textTheme;

  List<ThemeExtension> get extensions => [colors, textTheme];

  CustomTheme({required this.colors, required this.textTheme});

}

class DarkTheme extends CustomTheme {
  DarkTheme()
    : super(
      colors: _darkColors,
      textTheme: SharedTextTheme(colors: _darkColors),
  );
}

@riverpod
class ThemeController extends _$ThemeController {
  @override
  CustomTheme build() {
    return DarkTheme();
  }
}