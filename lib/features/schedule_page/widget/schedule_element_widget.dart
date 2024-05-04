import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:student_helper/common/domain/model/schedule_element/schedule_element.dart';
import 'package:student_helper/common/utils/context_extensions.dart';

import '../../../common/utils/color_types.dart';
import '../../../generated/locale_keys.g.dart';

class ScheduleElementWidget extends HookConsumerWidget {

  final int indexNumber;
  final ScheduleElementType type;
  final String subjectName;
  final DateTime startTime;
  final DateTime endTime;
  final ItemColor color;
  final String? homework;

  ScheduleElementWidget({
    super.key,
    required this.indexNumber,
    required this.type,
    required this.subjectName,
    required this.startTime,
    required this.endTime,
    required this.color,
    required this.homework
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: context.colors.secondary
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            Container(
              width: 10.w,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12)
                ),
                color: getColor(color, context)
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 9.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 9.w, right: 12.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      LocaleKeys.schedule_n_pair.tr(args: [indexNumber.toString()]),
                                      style: context.textTheme.mainFat.copyWith(
                                        color: context.colors.shared.white
                                      ),
                                    ),
                                    SizedBox(width: 15.w),
                                    Container(
                                      width: 32.w,
                                      decoration: BoxDecoration(
                                          color: context.colors.coldDarkGrey,
                                          borderRadius: BorderRadius.circular(12)
                                      ),
                                      child: Center(
                                        child: Text(
                                            type == ScheduleElementType.lecture
                                                ? LocaleKeys.schedule_lec.tr()
                                                : LocaleKeys.schedule_sem.tr()
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.h),
                                Text(
                                  "${startTime.hour}:${startTime.minute} - ${endTime.hour}:${endTime.minute}",
                                  style: context.textTheme.mainFat.copyWith(
                                    color: context.colors.shared.white
                                  )
                                )
                              ],
                            ),
                            SizedBox(width: 17.w),
                            Expanded(
                              child: Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                subjectName,
                                style: context.textTheme.subject.copyWith(
                                  color: context.colors.shared.white
                                ),
                                textAlign: TextAlign.end,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    if (homework != null)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 9.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 6.h),
                            Container(
                              height: 1.h,
                              color: context.colors.tertiary,
                            ),
                            SizedBox(height: 5.h),
                            Text(
                              homework!,
                              style: context.textTheme.mainLight.copyWith(
                                color: context.colors.shared.white
                              ),
                            )
                          ],
                        ),
                      )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}