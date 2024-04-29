import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:student_helper/common/utils/color_types.dart';
import 'package:student_helper/common/utils/context_extensions.dart';

class HomeworkPreviewWidget extends HookConsumerWidget {
  final String subjectName;
  final String text;
  final ItemColor color;

  HomeworkPreviewWidget({super.key, required this.subjectName, required this.text, required this.color});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 68.h,
      decoration: BoxDecoration(color: context.colors.tertiary, borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 10.w,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12)
              ),
              color: getColor(color, context),
            ),
          ),
          SizedBox(width: 5.w),
          Expanded(
            child: RichText(
                text: TextSpan(
                    text: "$subjectName: ",
                    style: context.textTheme.button.copyWith(color: context.colors.shared.white),
                    children: [
                      TextSpan(
                          text: text,
                          style: context.textTheme.main.copyWith(
                              color: context.colors.shared.white,
                          ))
                    ]),
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
