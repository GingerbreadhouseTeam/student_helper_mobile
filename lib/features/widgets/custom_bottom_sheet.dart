import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:student_helper/common/utils/context_extensions.dart';

class CBottomSheet extends HookConsumerWidget {
  final Widget child;

  CBottomSheet({super.key, required this.child});

  static Future<dynamic> show(BuildContext context, Widget child) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12))
        ),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height
        ),
        builder: (context) {
          return CBottomSheet(
              child: child
          );
        }
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.only(
          top: 15.h,
          right: 15.w,
          left: 15.w,
          bottom: 15.h),
      decoration: BoxDecoration(
        color: context.colors.tertiary,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12))
      ),
      child: child,
    );
  }}