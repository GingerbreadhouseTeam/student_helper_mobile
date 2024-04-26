import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:student_helper/common/utils/context_extensions.dart';

class BottomNavBarItem extends HookConsumerWidget {
  final SvgPicture image;
  final bool isSelected;
  final VoidCallback onTap;

  const BottomNavBarItem({
    super.key,
    required this.image,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50.h,
        width: 102.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected
              ? context.colors.accent50
              : null
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4.h),
          child: SizedBox(
            width: 43.h,
            height: 43.h,
            child: image,
          ),
        ),
      ),
    );
  }

}