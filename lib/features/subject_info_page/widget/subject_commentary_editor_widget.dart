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

class SubjectCommentaryEditorWidget extends HookConsumerWidget {

  final String initialCommentary;

  SubjectCommentaryEditorWidget({
    super.key,
    required this.initialCommentary
  });

  late final commentaryControl = FormControl(
      validators: [
        Validators.maxLength(250)
      ],
      value: initialCommentary
  );

  late final form = FormGroup({
    "commentaryControl": commentaryControl
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final controlValid = useState(commentaryControl.valid);

    return ReactiveFormBuilder(
      builder: (context, form, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.subjects_edit_commentary.tr(),
              style: context.textTheme.header2.copyWith(
                  color: context.colors.shared.white
              ),
            ),
            SizedBox(height: 20.h),
            ReactiveTextField(
              formControlName: "commentaryControl",
              onChanged: (control) {
                controlValid.value = control.valid;
              },
              maxLength: 250,
              maxLines: 8,
              decoration: InputDecoration(
                  hintText: LocaleKeys.subjects_commentary.tr()
              ),
            ),
            SizedBox(height: 20.h),
            CButton.primary(
                context: context,
                label: LocaleKeys.confirm.tr(),
                isEnabled: controlValid.value,
                onTap: () {
                  Navigator.of(context).pop(commentaryControl.value);
                }
            )
          ],
        );
      }, form: () => form,
    );
  }

}