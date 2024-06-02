import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:student_helper/common/utils/context_extensions.dart';
import 'package:student_helper/features/widgets/custom_buttons.dart';

import '../../common/domain/state/sign_in/sign_in_controller.dart';
import '../../generated/locale_keys.g.dart';

class SelectGroupPage extends HookConsumerWidget {

  final groupNameControl = FormControl(
    validators: [
      Validators.required,
      Validators.minLength(6)
    ]
  );

  final groupCodeControl = FormControl(
    validators: [
      Validators.required,
      Validators.minLength(6)
    ]
  );

  late final form = FormGroup(
      {
        "name": groupNameControl,
        "code": groupCodeControl
      }
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final formValid = useState(form.valid);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ReactiveFormBuilder(
        form: () => form,
        builder: (context, form, child) {
          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 25.w),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        LocaleKeys.auth_group_choice.tr(),
                        style: context.textTheme.screen.copyWith(
                          color: context.colors.accent
                        ),
                      ),
                      SizedBox(height: 62.h),
                      Text(
                        LocaleKeys.auth_enter_group_name.tr(),
                        textAlign: TextAlign.center,
                        style: context.textTheme.main.copyWith(
                          color: context.colors.accent
                        ),
                      ),
                      SizedBox(height: 44.h),
                      ReactiveTextField(
                        formControlName: 'name',
                        maxLength: 12,
                        onChanged: (control) {
                          formValid.value = form.valid;
                        },
                        decoration: InputDecoration(
                          hintText: LocaleKeys.auth_group_name.tr()
                        ),
                      ),
                      if (form.control('name').valid)
                        Padding(
                          padding: EdgeInsets.only(top: 44.h, bottom: 24.h),
                          child: Text(
                            LocaleKeys.auth_enter_unique_code.tr(),
                            textAlign: TextAlign.center,
                            style: context.textTheme.main.copyWith(
                              color: context.colors.accent
                            ),
                          ),
                        ),
                      if (form.control('name').valid)
                        ReactiveTextField(
                          formControlName: 'code',
                          maxLength: 6,
                          onChanged: (control) {
                            formValid.value = form.valid;
                          },
                          decoration: InputDecoration(
                            hintText: LocaleKeys.auth_code_mask.tr()
                          ),
                        )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 75.h, left: 25.w, right: 25.w),
                    child: CButton.primary(
                        context: context,
                        label: LocaleKeys.confirm.tr(),
                        isEnabled: formValid.value,
                        onTap: () {
                          //TODO Явная грязь
                          ref.read(signInControllerProvider.notifier).signIn(
                              email: "aaa",
                              password: 'bbb'
                          );
                        }
                    ),
                  )
              )
            ],
          );
        }
      ),
    );
  }
  
}