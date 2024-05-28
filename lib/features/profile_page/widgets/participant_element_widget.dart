import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:student_helper/common/utils/context_extensions.dart';

class ParticipantElementWidgent extends HookConsumerWidget {

  final bool isSelected;
  final String name;
  final VoidCallback onTap;

  ParticipantElementWidgent({
    super.key,
    required this.isSelected,
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 8.h,
            height: 8.h,
            decoration: BoxDecoration(
                color: isSelected
                    ? context.colors.accent
                    : null,
                shape: BoxShape.circle,
                border: Border.all(
                    color: context.colors.accent,
                    width: 1.w
                )
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            name,
            style: context.textTheme.main.copyWith(
                color: context.colors.shared.white
            ),
          )
        ],
      ),
    );
  }

}