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
import 'package:student_helper/common/utils/color_types.dart';
import 'package:student_helper/common/utils/context_extensions.dart';
import 'package:student_helper/common/utils/date_extensions.dart';
import 'package:student_helper/features/widgets/custom_buttons.dart';
import 'package:student_helper/generated/locale_keys.g.dart';

import '../../../generated/assets.gen.dart';

class EditHomeworkWidget extends HookConsumerWidget {

  final SubjectPreview subjectPreview;
  final DateTime? initialDate;
  final String? initialContent;
  final VoidCallback onDeleteTap;

  EditHomeworkWidget({
    super.key,
    required this.subjectPreview,
    required this.onDeleteTap,
    this.initialContent,
    this.initialDate
  });

  late final contentControl = FormControl(
    value: initialContent,
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
    final selectedDate = useState<DateTime?>(initialDate);

    final formValid = useState(true);

    return ReactiveFormBuilder(
        form: () => form,
        builder: (context, form, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                children: [
                  Align(
                    child: Text(
                      LocaleKeys.subjects_homework_editing.tr(),
                      style: context.textTheme.header2.copyWith(
                          color: context.colors.shared.white
                      ),
                    ),
                  ),
                  Positioned(
                      right: 0,
                      child: InkWell(
                        onTap: onDeleteTap,
                        borderRadius: BorderRadius.circular(90),
                        child: SizedBox(
                          width: 24.h,
                          height: 24.h,
                          child: Assets.images.icTrash.svg(),
                        ),
                      )
                  )
                ],
              ),
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                height: 48.h,
                decoration: BoxDecoration(
                  color: context.colors.secondary,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 12.h,
                      height: 12.h,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: getColor(subjectPreview.color, context)
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      subjectPreview.title,
                      style: context.textTheme.form.copyWith(
                          color: context.colors.accent
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 20.h),
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
                  label: LocaleKeys.confirm.tr(),
                  isEnabled: formValid.value,
                  onTap: () {
                    Navigator.of(context).pop();
                  }
              )
            ],
          );
        }
    );
  }


}