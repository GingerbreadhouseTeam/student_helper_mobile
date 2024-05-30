import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:student_helper/common/domain/model/profile_info/profile_info.dart';
import 'package:student_helper/common/utils/color_types.dart';
import 'package:student_helper/common/utils/context_extensions.dart';
import 'package:student_helper/common/utils/date_extensions.dart';
import 'package:student_helper/features/subject_info_page/widget/create_homework_widget.dart';
import 'package:student_helper/features/subject_info_page/widget/edit_homework_widget.dart';
import 'package:student_helper/features/subject_info_page/widget/subject_commentary_editor_widget.dart';
import 'package:student_helper/features/subject_info_page/widget/subject_teacher_commentary_widget.dart';
import 'package:student_helper/features/subject_info_page/widget/subject_name_editor_widget.dart';
import 'package:student_helper/features/widgets/custom_bottom_sheet.dart';
import 'package:student_helper/features/widgets/custom_buttons.dart';



import '../../common/domain/model/subject_preview/subject_preview.dart';
import '../../common/domain/state/profile_info/profile_info_controller.dart';
import '../../common/domain/state/subject_info/subject_info_controller.dart';
import '../../generated/assets.gen.dart';
import '../../generated/locale_keys.g.dart';

class SubjectInfoPage extends HookConsumerWidget {

  final String subjectId;

  SubjectInfoPage({
    super.key,
    required this.subjectId
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.read(profileInfoControllerProvider).value!;

    final state = ref.watch(subjectInfoControllerProvider(subjectId));

    final isInEditingMode = useState(false);

    final isInitialized = useState(false);

    final subjectName = useState('');
    final subjectControl = useState(SubjectControl.exam);
    final subjectCommentary = useState('');
    final subjectColor = useState(getColor(ItemColor.white, context));

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  (!isInEditingMode.value)
                   ? InkWell(
                      borderRadius: BorderRadius.circular(90),
                      onTap: () {
                        Routemaster.of(context).pop();
                      },
                      child: SizedBox(
                        width: 24.h,
                        height: 24.h,
                        child: Assets.images.icArrowRight.svg(),
                      ),
                    )
                  : SizedBox(width: 24.w),
                  Center(
                    child: Container(
                      width: 134.w,
                      height: 35.h,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
                        color: subjectColor.value
                      ),
                    ),
                  ),
                  (profile.role != UserRole.student && !isInEditingMode.value)

                   ? InkWell(
                        borderRadius: BorderRadius.circular(90),
                        onTap: (){
                          isInEditingMode.value = true;
                        },
                        child: SizedBox(
                            width: 24.h,
                            height: 24.h,
                            child: Assets.images.icEdit.svg()
                        )
                    )
                      : SizedBox(width: 24.w,)
                ],
              ),
            ),
            state.when(
                data: (info) {
                  if (!isInitialized.value){
                    subjectName.value = info.name;
                    subjectControl.value = info.control;
                    subjectCommentary.value = info.commentary;
                    subjectColor.value = getColor(info.color, context);
                    isInitialized.value = true;
                  }
                  return Expanded(
                    child: SizedBox(
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 30.h, bottom: 10.h),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: isInEditingMode.value
                                          ? () async {
                                        subjectName.value = await CBottomSheet.show(
                                            context,
                                            useRootNavigator: true,
                                            child:  SubjectNameEditorWidget(
                                                initialName: subjectName.value,
                                            )
                                        );
                                      }
                                          : null,
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                                        decoration: BoxDecoration(
                                          color: isInEditingMode.value
                                            ? context.colors.darkPrimary
                                            : null,
                                          borderRadius: BorderRadius.circular(12)
                                        ),
                                        child: Text(
                                          subjectName.value,
                                          style: context.textTheme.subject.copyWith(
                                            color: isInEditingMode.value
                                                ? context.colors.shared.white
                                                : context.colors.accent
                                          ),

                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: isInEditingMode.value
                                        ? () {
                                        if (subjectControl.value == SubjectControl.exam){
                                          subjectControl.value = SubjectControl.test;
                                        } else {
                                          subjectControl.value = SubjectControl.exam;
                                        }
                                      }
                                        : null,
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        width: 75.w,
                                        height: 25.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: isInEditingMode.value
                                              ? context.colors.darkPrimary
                                              : context.colors.secondary
                                        ),
                                        child: Center(
                                          child: Text(
                                            subjectControl.value == SubjectControl.exam
                                                ? LocaleKeys.subjects_exam.tr()
                                                : LocaleKeys.subjects_test.tr()
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 30.h),
                                SubjectTeacherCommentaryWidget(
                                    seminaryTeacher: info.seminaryTeacher,
                                    lectureTeacher: info.lectureTeacher,
                                    commentary: subjectCommentary.value,
                                    isEditingMode: isInEditingMode.value,
                                    onCommentaryTap: isInEditingMode.value
                                        ? () async {
                                      subjectCommentary.value = await CBottomSheet.show(
                                          context,
                                          useRootNavigator: true,
                                          child:  SubjectCommentaryEditorWidget(
                                            initialCommentary: subjectCommentary.value,
                                          )
                                      );
                                    }
                                        : null,
                                ),
                                SizedBox(height: 30.h),
                                Stack(
                                  children: [
                                    Align(
                                      child: Text(
                                        LocaleKeys.subjects_homeworks.tr(),
                                        textAlign: TextAlign.center,
                                        style: context.textTheme.header2.copyWith(
                                            color: context.colors.accent
                                        ),
                                      ),
                                    ),
                                    if (profile.role != UserRole.student)
                                      Positioned(
                                        right: 0,
                                        child: InkWell(
                                          onTap: () {
                                            CBottomSheet.show(
                                                context,
                                                useRootNavigator: true,
                                                child: CreateHomeworkWidget(
                                                  subjectPreview: SubjectPreview(
                                                      id: info.subjectId,
                                                      control: info.control,
                                                      color: info.color,
                                                      title: info.name,
                                                  ),
                                                )
                                            );
                                          },
                                          borderRadius: BorderRadius.circular(90),
                                          child: SizedBox(
                                            height: 30.h,
                                            width: 30.h,
                                            child: Assets.images.icPlus.svg(),
                                          ),
                                        ),
                                      )
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                Container(
                                  width: 310.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: context.colors.darkPrimary
                                  ),
                                  child: ListView.separated(
                                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: isInEditingMode.value
                                            ? () {
                                            CBottomSheet.show(
                                                context,
                                                useRootNavigator: true,
                                                child: EditHomeworkWidget(
                                                    onDeleteTap: () {},
                                                    subjectPreview: SubjectPreview(
                                                        id: info.subjectId,
                                                        control: info.control,
                                                        color: info.color,
                                                        title: info.name
                                                    ),
                                                  initialContent: info.homeworks[index].title,
                                                  initialDate: info.homeworks[index].dadd,
                                                )
                                            );
                                          } : null,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: Text(
                                                    info.homeworks[index].title,
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: context.textTheme.main.copyWith(
                                                      color: context.colors.accent50
                                                    ),
                                                  )
                                              ),
                                              SizedBox(
                                                  width: info.homeworks[index].dadd != null
                                                      ? 30.h
                                                      : 0
                                              ),
                                              if (info.homeworks[index].dadd != null)
                                                Container(
                                                  width: 38.w,
                                                  height: 17.h,
                                                  decoration: BoxDecoration(
                                                    color: context.colors.secondary,
                                                    borderRadius: BorderRadius.circular(12)
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      info.homeworks[index].dadd!.getMonthDayDotMonth(),
                                                      style: context.textTheme.smol.copyWith(
                                                        color: context.colors.accent
                                                      ),
                                                    ),
                                                  ),
                                                )
                                            ],
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return SizedBox(height: 12.h);
                                      },
                                      itemCount: info.homeworks.length
                                  ),
                                ),
                                if (isInEditingMode.value)
                                  SizedBox(height: 227.h)

                              ],
                            ),
                          ),
                          if (isInEditingMode.value)
                            Positioned(
                                bottom: 39.h,
                                left: 25.w,
                                width: 310.w,
                                child: CButton.primary(
                                    context: context,
                                    label: LocaleKeys.confirm.tr(),
                                    onTap: () {
                                      isInEditingMode.value = false;
                                      ref.invalidate(subjectInfoControllerProvider);
                                    }
                                )
                            )
                        ],
                      ),
                    ),
                  );
                },
                error: (error, stackTrace) {
                  return Text("Ошибаешься... \n и вот почему \n ${error} \n${stackTrace}");
                },
                loading: () {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
            )
          ],
        ),
      ),
    );


  }

}