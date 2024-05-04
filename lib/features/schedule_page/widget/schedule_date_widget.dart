import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:student_helper/common/utils/context_extensions.dart';

class ScheduleDateWidget extends HookConsumerWidget {

  final String weekday;
  final String day;
  final VoidCallback onTap;
  final bool isSelected;

  ScheduleDateWidget({
    super.key,
    required this.weekday,
    required this.day,
    required this.onTap,
    required this.isSelected
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 48.w,
        height: 58.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: isSelected
                ? context.colors.accent50
                : context.colors.primary
        ),
        child: Center(
          child: Column(
            children: [
              Text(
                weekday,
                style: context.textTheme.main.copyWith(
                  color: isSelected
                      ? context.colors.tertiary
                      : context.colors.coldGrey
                ),
              ),
              SizedBox(height: 7.h),
              Text(
                day,
                style: context.textTheme.main.copyWith(
                  color: context.colors.shared.white
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}