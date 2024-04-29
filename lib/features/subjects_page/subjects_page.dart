import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:student_helper/common/domain/state/homework_preview/homework_preview_controller.dart';
import 'package:student_helper/common/domain/state/subject_preview/subject_preview_controller.dart';
import 'package:student_helper/common/utils/context_extensions.dart';
import 'package:student_helper/features/subjects_page/widget/homework_preview_widget.dart';
import 'package:student_helper/features/subjects_page/widget/subject_preview_widget.dart';

import '../../generated/locale_keys.g.dart';

class SubjectsPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjectPreviewState = ref.watch(subjectPreviewControllerProvider);
    final homeworkPreviewState = ref.watch(homeworkPreviewControllerProvider);

    return Column(
      children: [
        subjectPreviewState.when(
            data: (subjects) {
              return SizedBox(
                height: 331.h,
                child: RefreshIndicator(
                  onRefresh: () async {
                    ref.invalidate(subjectPreviewControllerProvider);
                  },
                  child: GridView.builder(
                    itemCount: subjects.length,
                    padding: EdgeInsets.only(
                      top: 18.h,
                      left: 25.w,
                      right: 25.w,
                      bottom: 20.h
                    ),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 26.h,
                          crossAxisSpacing: 56.w,
                          crossAxisCount: 2,
                          childAspectRatio: 130.w / 83.h
                      ),
                      itemBuilder: (context, index) {
                        return SubjectPreviewWidget(
                            control: subjects[index].control,
                            color: subjects[index].color,
                            title: subjects[index].title
                        );
                      }
                  ),
                ),
              );
            },
            error: (error, stackTrace) {
              return Text("Ошибаешься... \n и вот почему \n ${error}");
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
        ),
        Container(
          height: 1.h,
          color: context.colors.tertiary,
        ),
        SizedBox(height: 12.h),
        Text(
          LocaleKeys.subjects_homeworks.tr(),
          style: context.textTheme.header2.copyWith(
            color: context.colors.accent
          ),
        ),
        homeworkPreviewState.when(
            data: (homework) {
              return Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.only(
                    top: 14.h,
                    left: 25.w,
                    right: 25.w,
                    bottom: 50.h + MediaQuery.of(context).viewPadding.bottom
                  ),
                  shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return HomeworkPreviewWidget(
                          subjectName: homework[index].subjectName,
                          text: homework[index].text,
                          color: homework[index].color
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 14.h);
                    },
                    itemCount: homework.length
                ),
              );
            },
            error: (error, stackTrace) {
              return Text("Ошибаешься... \n и вот почему \n ${error}");
            },
            loading: () {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
        )
      ],
    );
  }
  
}