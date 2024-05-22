import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:student_helper/common/domain/model/subject_preview/subject_preview.dart';
import 'package:student_helper/common/utils/color_types.dart';
import 'package:student_helper/common/utils/context_extensions.dart';

import '../../../generated/locale_keys.g.dart';

class SubjectPreviewWidget extends HookConsumerWidget {

  final SubjectControl control;
  final ItemColor color;
  final String title;

  SubjectPreviewWidget({
    super.key,
    required this.control,
    required this.color,
    required this.title
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.secondary,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 8.h,
          left: 7.w,
          right: 10.w,
          bottom: 4.h
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: Row(
                      children: [
                        Container(
                          width: 32.w,
                          decoration: BoxDecoration(
                            color: context.colors.coldDarkGrey,
                            borderRadius: BorderRadius.circular(12)
                          ),
                          child: Center(
                            child: Text(
                              control == SubjectControl.exam
                                  ? LocaleKeys.subjects_ex.tr()
                                  : LocaleKeys.subjects_tst.tr()
                            ),
                          ),
                        ),
                      ],
                    )
                ),
                Container(
                  width: 12.h,
                  height: 12.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: getColor(color, context)
                  ),
                )
              ],
            ),
            SizedBox(height: 14.h),
            Text(
              title,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: context.textTheme.button.copyWith(
                color: context.colors.shared.white
              ),
            ),
          ],
        ),
      ),
    );
  }

}