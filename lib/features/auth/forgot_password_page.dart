import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:routemaster/routemaster.dart';
import 'package:student_helper/common/utils/context_extensions.dart';
import 'package:student_helper/common/utils/validators.dart';

import '../../generated/locale_keys.g.dart';
import '../widgets/custom_buttons.dart';

class ForgotPasswordPage extends HookConsumerWidget {

  final form = FormGroup({
    "email": FormControl(
      validators: [
        Validators.required,
        emailValidator
      ]
    )
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ReactiveFormBuilder(
          form: () => form,
          builder: (context, formGroup, child){
            return Padding(
              padding: EdgeInsets.only(top: 24.h + MediaQuery.of(context).viewPadding.top, left: 25.w, right: 25.w),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.auth_password_recovery.tr(),
                        textAlign: TextAlign.center,
                        style: context.textTheme.screen.copyWith(
                          color: context.colors.accent
                        ),
                      ),
                      SizedBox(height: 16.h),
                      Text(
                        LocaleKeys.auth_enter_email_for_password_reset.tr(),
                        textAlign: TextAlign.center,
                        style: context.textTheme.main.copyWith(
                          color: context.colors.accent
                        ),
                      ),
                      SizedBox(height: 44.h),
                      ReactiveTextField(
                        formControlName: "email",
                        decoration: InputDecoration(
                            hintText: LocaleKeys.auth_email.tr()
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 89.h),
                      child: CButton.primary(
                          context: context,
                          label: LocaleKeys.auth_confirm.tr(),
                          isEnabled: form.valid,
                          onTap: () {
                            Routemaster.of(context).push('complete');
                          }
                      ),
                    ),

                  )
                ],
              ),
            );
          }
      ),
    );
  }

}