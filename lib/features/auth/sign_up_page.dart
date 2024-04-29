import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:student_helper/common/utils/context_extensions.dart';
import 'package:student_helper/common/utils/validators.dart';

import '../../generated/assets.gen.dart';
import '../../generated/locale_keys.g.dart';

class SignUpPage extends HookConsumerWidget {

  final form = FormGroup({
    "fullName": FormControl<String>(
      validators: [
        Validators.required
      ]
    ),
    "email": FormControl<String>(
      validators: [
        Validators.required,
        emailValidator,
      ]
    ),
    "password": FormControl<String>(
      validators: [
        Validators.required,
        Validators.minLength(6)
      ]
    ),
    "passwordConfirmation": FormControl<String>()
  }, validators: [
    const MustMatchValidator('password', 'passwordConfirmation', true)
  ]
  );

  SignUpPage({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final passwordObscure = useState(true);
    final passwordConfirmObscure = useState(true);

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 24.h + MediaQuery.of(context).viewPadding.top,
              left: 25.w,
              right: 25.w
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.auth_sign_up.tr(),
                    style: context.textTheme.screen.copyWith(
                      color: context.colors.accent
                    ),
                  ),
                  SizedBox(height: 16.h),
                  ReactiveForm(
                      formGroup: form,
                      child: Column(
                        children: [
                          ReactiveTextField(
                            formControlName: "fullName",
                            decoration: InputDecoration(
                              hintText: LocaleKeys.auth_full_name.tr()
                            ),
                          ),
                          SizedBox(height: 30.h),
                          ReactiveTextField(
                            formControlName: "email",
                            decoration: InputDecoration(
                              hintText: LocaleKeys.auth_email.tr()
                            ),
                          ),
                          SizedBox(height: 30.h),
                          ReactiveTextField(
                            formControlName: "password",
                            obscureText: passwordObscure.value,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                              hintText: LocaleKeys.auth_password.tr(),
                              suffixIcon: InkWell(
                                onTap: () {
                                  passwordObscure.value = !passwordObscure.value;
                                },
                                child: SizedBox(
                                  width: 24.h,
                                  height: 24.h,
                                  child: passwordObscure.value
                                      ? Assets.images.icViewHide.svg(
                                    fit: BoxFit.scaleDown)
                                      : Assets.images.icView.svg(
                                      fit: BoxFit.scaleDown),
                                ),
                              )
                            ),
                          ),
                          SizedBox(height: 30.h),
                          ReactiveTextField(
                            formControlName: "passwordConfirmation",
                            obscureText: passwordConfirmObscure.value,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                              hintText: LocaleKeys.auth_password_confirm.tr(),
                              suffixIcon: InkWell(
                                onTap: () {
                                  passwordConfirmObscure.value = !passwordConfirmObscure.value;
                                },
                                child: SizedBox(
                                  width: 24.h,
                                  height: 24.h,
                                  child: passwordConfirmObscure.value
                                      ? Assets.images.icViewHide.svg(
                                      fit: BoxFit.scaleDown)
                                      : Assets.images.icView.svg(
                                      fit: BoxFit.scaleDown),
                                ),
                              )
                            ),
                          )
                        ],
                      )
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

}