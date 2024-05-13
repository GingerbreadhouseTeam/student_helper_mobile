import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:student_helper/common/utils/context_extensions.dart';

abstract interface class CButtonStyle {
  abstract final ButtonStyle style;
  abstract final Widget label;
  abstract final Color progressColor;
}

class PrimaryButton extends CButtonStyle {
  final BuildContext context;
  final String text;
  final bool isEnabled;

  PrimaryButton(this.context, this.text, this.isEnabled);

  @override
  Widget get label => Text(
    text,
    style: context.textTheme.button.copyWith(
      color:  context.colors.primary
    ),
  );

  @override
  Color get progressColor => context.colors.primary;

  @override
  ButtonStyle get style => ButtonStyle(
    backgroundColor: MaterialStateProperty.all(
      isEnabled
          ? context.colors.accent
          : context.colors.coldGrey,
    ),
    maximumSize: MaterialStateProperty.all(
      Size(double.infinity, 43.h)
    ),
    minimumSize: MaterialStateProperty.all(
      Size(double.infinity, 43.h)
    ),
    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      )
    ),
    elevation: MaterialStateProperty.all(0)
  );

}

class CButton extends HookConsumerWidget {

  final VoidCallback onTap;
  final bool isLoading;
  final bool isEnabled;
  final CButtonStyle style;

  CButton.primary({
    super.key,
    required BuildContext context,
    required String label,
    required this.onTap,
    this.isLoading = false,
    this.isEnabled = true
}) : style = PrimaryButton(context, label, isEnabled);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
        style: style.style,
        onPressed: canTap ? onTap : null,
        child: isLoading
            ? CircularProgressIndicator(color: style.progressColor)
            : style.label
    );
  }

  bool get canTap => isEnabled && !isLoading;

}