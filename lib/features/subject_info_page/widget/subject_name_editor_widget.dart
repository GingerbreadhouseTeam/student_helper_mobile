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

class SubjectNameEditorWidget extends HookConsumerWidget {

  final String initialName;

  SubjectNameEditorWidget({
    super.key,
    required this.initialName
  });

  late final nameControl = FormControl(
    validators: [
      Validators.required,
      Validators.maxLength(10)
    ],
    value: initialName
  );

  late final form = FormGroup({
    "nameControl": nameControl
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final controlValid = useState(nameControl.valid);

    return ReactiveFormBuilder(
      builder: (context, form, child) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.subjects_edit_name.tr(),
              style: context.textTheme.header2.copyWith(
                  color: context.colors.shared.white
              ),
            ),
            SizedBox(height: 20.h),
            ReactiveTextField(
              formControlName: "nameControl",
              onChanged: (control) {
                controlValid.value = control.valid;
              },
              maxLength: 10,
              decoration: InputDecoration(
                hintText: LocaleKeys.subjects_name.tr()
              ),
            ),
            SizedBox(height: 20.h),
            CButton.primary(
                context: context,
                label: LocaleKeys.confirm.tr(),
                isEnabled: controlValid.value,
                onTap: () {
                  Navigator.of(context).pop(nameControl.value);
                }
            )
          ],
        );
      }, form: () => form,
    );
  }

}