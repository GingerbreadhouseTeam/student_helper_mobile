import 'package:dart_date/dart_date.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:student_helper/common/domain/model/subject_preview/subject_preview.dart';
import 'package:student_helper/common/domain/state/subject_preview/subject_preview_controller.dart';
import 'package:student_helper/common/utils/color_types.dart';
import 'package:student_helper/common/utils/context_extensions.dart';
import 'package:student_helper/common/utils/date_extensions.dart';
import 'package:student_helper/features/widgets/custom_buttons.dart';
import 'package:student_helper/features/widgets/select_subject_widget.dart';
import 'package:student_helper/generated/locale_keys.g.dart';

import '../../../generated/assets.gen.dart';

class CreateHomeworkWidget extends HookConsumerWidget {

  final SubjectPreview? subjectPreview;

  CreateHomeworkWidget({
    super.key,
    this.subjectPreview,
  });

  final contentControl = FormControl(
    validators: [
      Validators.required,
      Validators.maxLength(100)
    ]
  );

  late final form = FormGroup({
    "contentControl": contentControl
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final selectedSubjectPreview = useState(subjectPreview);

    final subjects = useState<List<SubjectPreview>?>([]);

    final tileController = useExpansionTileController();

    final selectedDate = useState<DateTime?>(null);

    final formValid = useState(false);
    
    if (subjectPreview == null){
      subjects.value = ref.watch(subjectPreviewControllerProvider).value;
    }

    if (subjects.value == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }


    return ReactiveFormBuilder(
      form: () => form,
      builder: (context, form, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              LocaleKeys.subjects_new_homework.tr(),
              style: context.textTheme.header2.copyWith(
                color: context.colors.shared.white
              ),
            ),
            SizedBox(height: 20.h),
            Stack(
              children: [
                Padding(
                    padding: EdgeInsets.only(top: 90.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            selectedDate.value = await showDatePicker(
                                context: context,
                                firstDate: DateTime.now(),
                                lastDate: DateTime.now().addMonths(1)
                            );
                          },
                          child: Container(
                            height: 48.h,
                            padding: EdgeInsets.symmetric(
                              vertical: 12.h,
                              horizontal: 12.w
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: context.colors.secondary,
                              border: selectedDate.value == null
                                ? Border.all(
                                color: context.colors.accent,
                                width: 1.w
                              )
                                  : null
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                      selectedDate.value == null
                                          ? LocaleKeys.subjects_deadline.tr()
                                          : selectedDate.value!.getFullDateWithSlashes(),
                                      style: selectedDate.value == null
                                        ? context.textTheme.mainLight.copyWith(
                                        color: context.colors.accent50,
                                      )
                                          : context.textTheme.form.copyWith(
                                        color: context.colors.accent
                                      )
                                    )
                                ),
                                SizedBox(
                                  width: 24.h,
                                  height: 24.h,
                                  child: Assets.images.icCalendar.svg(),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        ReactiveTextField(
                          formControlName: "contentControl",
                          maxLines: 5,
                          maxLength: 100,
                          onChanged: (control) {
                            formValid.value = control.valid;
                          },
                          decoration: InputDecoration(
                            hintText: LocaleKeys.subjects_contents.tr()
                          ),
                        ),
                        SizedBox(height: 20.h),
                        CButton.primary(
                            context: context,
                            label: LocaleKeys.create.tr(),
                            isEnabled: formValid.value && selectedSubjectPreview.value != null,
                            onTap: () {
                              Navigator.of(context).pop();
                            }
                        )
                      ],
                    ),
                ),
                SelectSubjectWidget(
                    tileController: tileController,
                    subjectPreview: subjectPreview,
                    selectedSubjectPreview: selectedSubjectPreview,
                    subjects: subjects
                )
              ],
            )
          ],
        );
      }
    );
  }

}