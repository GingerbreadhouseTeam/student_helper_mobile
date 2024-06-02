import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:student_helper/common/utils/context_extensions.dart';

import '../../generated/assets.gen.dart';

class ElementAddWidget extends HookConsumerWidget {
  
  final VoidCallback onTap;

  ElementAddWidget({
    super.key,
    required this.onTap
  });
  
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        color: context.colors.coldGrey,
        dashPattern: const [3, 3],
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 13.h),
            child: Center(
              child: SizedBox(
                width: 52.h,
                height: 52.h,
                child: Assets.images.plusButton.svg(),
              ),
            ),
          ),
        ),
      ),
    );
  }

}