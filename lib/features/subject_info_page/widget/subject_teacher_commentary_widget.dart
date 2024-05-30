import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:student_helper/common/utils/context_extensions.dart';

import '../../../generated/locale_keys.g.dart';

class SubjectTeacherCommentaryWidget extends HookConsumerWidget {

  final String? seminaryTeacher;
  final String? lectureTeacher;
  final String? commentary;

  final bool isEditingMode;
  final VoidCallback? onCommentaryTap;

  SubjectTeacherCommentaryWidget({
    super.key,
    this.seminaryTeacher,
    this.lectureTeacher,
    this.commentary,
    required this.isEditingMode,
    required this.onCommentaryTap
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: context.colors.secondary,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            LocaleKeys.subjects_teachers.tr(),
            style: context.textTheme.main.copyWith(
                color:
                isEditingMode
                    ? context.colors.accent50
                    : context.colors.shared.white
            )
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    seminaryTeacher ?? LocaleKeys.subjects_teacher_not_found.tr(),
                    style: context.textTheme.mainLight.copyWith(
                      color:
                      isEditingMode
                          ? context.colors.accent50
                          : context.colors.shared.white
                    ),
                  ),
                ),
                Container(
                  width: 30.w,
                  height: 15.h,
                  decoration: BoxDecoration(
                    color: context.colors.coldDarkGrey,
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Center(
                    child:  Text(
                      LocaleKeys.schedule_sem.tr(),
                      style: context.textTheme.smol.copyWith(
                        color: isEditingMode
                            ? context.colors.accent50
                            : context.colors.shared.white
                      ),
                    )
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 6.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.h),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    lectureTeacher ?? LocaleKeys.subjects_teacher_not_found.tr(),
                    style: context.textTheme.mainLight.copyWith(
                        color: isEditingMode
                            ? context.colors.accent50
                            : context.colors.shared.white
                    ),
                  ),
                ),
                Container(
                  width: 30.w,
                  height: 15.h,
                  decoration: BoxDecoration(
                      color: context.colors.coldDarkGrey,
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: Center(
                      child:  Text(
                        LocaleKeys.schedule_lec.tr(),
                        style: context.textTheme.smol.copyWith(
                            color: isEditingMode
                                ? context.colors.accent50
                                : context.colors.shared.white
                        ),
                      )
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            height: 1.h,
            color: context.colors.tertiary,
          ),
          SizedBox(height: 8.h),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.h),
              child: GestureDetector(
                onTap: onCommentaryTap,
                child: Text(
                  !(commentary == "" || commentary == null)
                    ? commentary!
                    : LocaleKeys.subjects_click_to_add_commentary.tr(),
                  maxLines: 8,
                  style: context.textTheme.mainLight.copyWith(
                    color: isEditingMode
                        ? context.colors.shared.white
                        : context.colors.accent
                  ),
                ),
              ),
          )
        ],
      ),
    );
  }

}