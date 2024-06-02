import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:student_helper/common/utils/context_extensions.dart';
import 'package:student_helper/features/widgets/custom_buttons.dart';

import '../../../generated/locale_keys.g.dart';

class TopicCreateEditWidget extends HookConsumerWidget {

  final void Function(String content, bool isAssignToMe) onCreateTap;

  TopicCreateEditWidget({
    super.key,
    required this.onCreateTap,
  });

  final contentControl = FormControl(
      validators: [
        Validators.required,
        Validators.maxLength(100)
      ]
  );

  late final form = FormGroup({
    "content": contentControl
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final formValid = useState(contentControl.valid);
    final isAssignToMe = useState(false);

    return ReactiveFormBuilder(
      form: () => form,
      builder: (context, form, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.topic_new.tr(),
              style: context.textTheme.header2.copyWith(
                color: context.colors.shared.white
              ),
            ),
            SizedBox(height: 20.h),
            ReactiveTextField(
              formControlName: "content",
              maxLength: 100,
              maxLines: 5,
              onChanged: (control) {
                formValid.value = control.valid;
              },
              decoration: InputDecoration(
                hintText: LocaleKeys.subjects_contents.tr(),
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                    child: Text(
                      LocaleKeys.topic_assign_to_me.tr(),
                      style: context.textTheme.main.copyWith(
                        color: context.colors.shared.white
                      ),
                    ),
                ),
                Checkbox(
                    value: isAssignToMe.value,
                    onChanged: (value) {
                      isAssignToMe.value = !isAssignToMe.value;
                    }
                )
              ],
            ),
            SizedBox(height: 20.h),
            CButton.primary(
                context: context,
                label: LocaleKeys.create.tr(),
                isEnabled: formValid.value,
                onTap: () {
                  onCreateTap(contentControl.value, isAssignToMe.value);
                }
            )
          ],
        );
      }
    );
  }

}