import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_helper/common/utils/themes/app_theme.dart';

extension ContextExtensions on BuildContext {

  CustomColors get colors => Theme.of(this).extension<CustomColors>()!;

  CustomTextTheme get textTheme => Theme.of(this).extension<CustomTextTheme>()!;
}