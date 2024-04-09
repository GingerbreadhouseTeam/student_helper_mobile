import 'package:flutter/material.dart';

abstract class CustomTheme {
  final CustomColors colors;
  final CustomTextTheme textTheme;



  List<ThemeExtension> get extensions => [colors, textTheme];

  CustomTheme({
    required this.colors,
    required this.textTheme
  });
}

final class SharedColors {
}

class CustomColors extends ThemeExtension<CustomColors> {
  @override
  ThemeExtension<CustomColors> copyWith() {
    // TODO: implement copyWith
    throw UnimplementedError();
  }

  @override
  ThemeExtension<CustomColors> lerp(covariant ThemeExtension<CustomColors>? other, double t) {
    // TODO: implement lerp
    throw UnimplementedError();
  }

}

class CustomTextTheme extends ThemeExtension<CustomTextTheme> {
  @override
  ThemeExtension<CustomTextTheme> copyWith() {
    // TODO: implement copyWith
    throw UnimplementedError();
  }

  @override
  ThemeExtension<CustomTextTheme> lerp(covariant ThemeExtension<CustomTextTheme>? other, double t) {
    // TODO: implement lerp
    throw UnimplementedError();
  }

}

class SharedTextTheme extends CustomTextTheme {
  SharedTextTheme({
    required CustomColors colors,
}) : super ();
}