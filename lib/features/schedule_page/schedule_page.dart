import 'package:dart_date/dart_date.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:student_helper/common/domain/model/profile_info/profile_info.dart';
import 'package:student_helper/common/domain/state/profile_info/profile_info_controller.dart';
import 'package:student_helper/common/domain/state/schedule_element/schedule_element_controller.dart';
import 'package:student_helper/common/utils/context_extensions.dart';
import 'package:student_helper/common/utils/date_extensions.dart';
import 'package:student_helper/common/utils/schedule_dates_creator.dart';
import 'package:student_helper/features/schedule_page/widget/schedule_date_widget.dart';
import 'package:student_helper/features/schedule_page/widget/schedule_element_widget.dart';
import 'package:student_helper/features/subject_info_page/widget/create_homework_widget.dart';
import 'package:student_helper/features/widgets/custom_bottom_sheet.dart';
import 'package:student_helper/features/widgets/custom_buttons.dart';

import '../../generated/assets.gen.dart';
import '../../generated/locale_keys.g.dart';

class SchedulePage extends HookConsumerWidget {

  final scheduleWeeks = ScheduleDateCreator().createSchedule(DateTime(2024, 3, 10));

  @override
  Widget build(BuildContext context, WidgetRef ref) {



    final selectedDate = useState(
        DateTime.now().weekday != 7
          ? DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          : DateTime(DateTime.now().previousDay.year, DateTime.now().previousDay.month, DateTime.now().previousDay.day)
    );
    final state = ref.watch(scheduleElementControllerProvider);
    final profileState = ref.watch(profileInfoControllerProvider);

    final selectedWeek = useState(
        scheduleWeeks.entries
            .where(
                (element) =>
                element.value
                    .contains(DateTime(
                    selectedDate.value.year,
                    selectedDate.value.month,
                    selectedDate.value.day
                )))
            .first
            .key
    );
    useAutomaticKeepAlive();

    if (state is AsyncError) {
      return Text("Ошибаешься... \n и вот почему \n ${state.error}");
    }

    if (state is AsyncLoading && !state.hasValue){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    if (profileState is AsyncError) {
      return Text("Ошибаешься... \n и вот почему \n ${state.error}");
    }

    if (profileState is AsyncLoading){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }



    final schedule = state.value!;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(
              top: 8.h,
              left: 25.w,
              right: 25.w
          ),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  if (selectedWeek.value != 1) {
                    selectedWeek.value = selectedWeek.value - 1;
                    selectedDate.value = scheduleWeeks[selectedWeek.value]!.last;
                    ref.read(scheduleElementControllerProvider.notifier).filterSchedule(selectedDate.value);
                  }
                },
                borderRadius: BorderRadius.circular(120),
                child: SizedBox(
                  width: 28.h,
                  height: 28.h,
                  child: Assets.images.icExpandLeft.svg(),
                ),
              ),
              Expanded(
                  child: Text(
                    LocaleKeys.schedule_date_with_week.tr(args: [
                      selectedDate.value.getMonthNameYear(),
                      selectedWeek.value.toString()
                    ]),
                    style: context.textTheme.main.copyWith(
                        color: context.colors.shared.white
                    ),
                    textAlign: TextAlign.center,
                  )
              ),
              InkWell(
                onTap: () {
                  if (selectedWeek.value != 18) {
                    selectedWeek.value = selectedWeek.value + 1;
                    selectedDate.value = scheduleWeeks[selectedWeek.value]!.first;
                    ref.read(scheduleElementControllerProvider.notifier).filterSchedule(selectedDate.value);
                  }
                },
                borderRadius: BorderRadius.circular(120),
                child: SizedBox(
                  width: 28.h,
                  height: 28.h,
                  child: Assets.images.icExpandRight.svg(),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: 18.h,
              left: 25.w,
              right: 25.w
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ScheduleDateWidget(
                  weekday: LocaleKeys.weekday_names_MON.tr(),
                  day: scheduleWeeks[selectedWeek.value]![0].day.toString(),
                  onTap: () {
                    selectedDate.value = scheduleWeeks[selectedWeek.value]![0];
                    ref.read(scheduleElementControllerProvider.notifier).filterSchedule(selectedDate.value);
                  },
                  isSelected: selectedDate.value == scheduleWeeks[selectedWeek.value]![0]
              ),
              ScheduleDateWidget(
                  weekday: LocaleKeys.weekday_names_TUE.tr(),
                  day: scheduleWeeks[selectedWeek.value]![1].day.toString(),
                  onTap: () {
                    selectedDate.value = scheduleWeeks[selectedWeek.value]![1];
                    ref.read(scheduleElementControllerProvider.notifier).filterSchedule(selectedDate.value);
                  },
                  isSelected: selectedDate.value == scheduleWeeks[selectedWeek.value]![1]
              ),
              ScheduleDateWidget(
                  weekday: LocaleKeys.weekday_names_WED.tr(),
                  day: scheduleWeeks[selectedWeek.value]![2].day.toString(),
                  onTap: () {
                    selectedDate.value = scheduleWeeks[selectedWeek.value]![2];
                    ref.read(scheduleElementControllerProvider.notifier).filterSchedule(selectedDate.value);
                  },
                  isSelected: selectedDate.value == scheduleWeeks[selectedWeek.value]![2]
              ),
              ScheduleDateWidget(
                  weekday: LocaleKeys.weekday_names_THU.tr(),
                  day: scheduleWeeks[selectedWeek.value]![3].day.toString(),
                  onTap: () {
                    selectedDate.value = scheduleWeeks[selectedWeek.value]![3];
                    ref.read(scheduleElementControllerProvider.notifier).filterSchedule(selectedDate.value);
                  },
                  isSelected: selectedDate.value == scheduleWeeks[selectedWeek.value]![3]
              ),
              ScheduleDateWidget(
                  weekday: LocaleKeys.weekday_names_FRI.tr(),
                  day: scheduleWeeks[selectedWeek.value]![4].day.toString(),
                  onTap: () {
                    selectedDate.value = scheduleWeeks[selectedWeek.value]![4];
                    ref.read(scheduleElementControllerProvider.notifier).filterSchedule(selectedDate.value);
                  },
                  isSelected: selectedDate.value == scheduleWeeks[selectedWeek.value]![4]
              ),
              ScheduleDateWidget(
                  weekday: LocaleKeys.weekday_names_SAT.tr(),
                  day: scheduleWeeks[selectedWeek.value]![5].day.toString(),
                  onTap: () {
                    selectedDate.value = scheduleWeeks[selectedWeek.value]![5];
                    ref.read(scheduleElementControllerProvider.notifier).filterSchedule(selectedDate.value);
                  },
                  isSelected: selectedDate.value == scheduleWeeks[selectedWeek.value]![5]
              )
            ],
          ),
        ),
        SizedBox(height: 25.h),
        Expanded(
          child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.only(
                  left: 25.w,
                  right: 25.w,
                  bottom: 3.h
              ),
              itemBuilder: (context, index) {

                if (index == state.value!.length && profileState.value!.role != UserRole.student) {
                  return CButton.primary(
                      context: context,
                      label: LocaleKeys.schedule_add_hometask.tr(),
                      onTap: () {
                        CBottomSheet.show(
                            context,
                            useRootNavigator: true,
                            child: CreateHomeworkWidget()
                        );
                      }
                  );
                }

                schedule.sort((a, b) => a.indexNumber.compareTo(b.indexNumber));
                return ScheduleElementWidget(
                    indexNumber: schedule[index].indexNumber,
                    type: schedule[index].type,
                    subjectName: schedule[index].subjectName,
                    startTime: schedule[index].start,
                    endTime: schedule[index].end,
                    color: schedule[index].color,
                    homework: schedule[index].homework
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(
                  height: 26.h,
                );
              },
              itemCount: state.value!.length + 1
          ),
        )
      ],
    );


  }



}