import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:routemaster/routemaster.dart';
import 'package:student_helper/common/utils/context_extensions.dart';
import 'package:student_helper/common/utils/validators.dart';

import '../../generated/assets.gen.dart';
import '../../generated/locale_keys.g.dart';
import '../widgets/custom_buttons.dart';

class SignUpPage extends HookConsumerWidget {

  final authForm = FormGroup({
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
    "passwordConfirmation": FormControl<String>(
      validators: [
        Validators.required
      ]
    )
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
      resizeToAvoidBottomInset: false,
      body: KeyboardVisibilityBuilder(
          builder: (context, isVisible) {
            return ReactiveFormBuilder(
              form: () => authForm,
              builder: (context, form, child) {
                return Stack(
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
                            Column(
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
                            ),
                            SizedBox(height: 25.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  LocaleKeys.auth_already_have_account_question.tr(),
                                  style: context.textTheme.mainLight.copyWith(
                                      color: context.colors.accent
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    Routemaster.of(context).push('/sign_in');
                                  },
                                  child: Text(
                                    LocaleKeys.auth_sign_in_action.tr(),
                                    style: context.textTheme.mainFat.copyWith(
                                        color: context.colors.shared.white
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 25.w,
                            right: 25.w,
                            bottom: 5.h + MediaQuery.of(context).viewPadding.bottom
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                              child: CButton.primary(
                                  context: context,
                                  label: LocaleKeys.auth_confirm.tr(),
                                  isEnabled: form.valid,
                                  onTap: () {}
                              ),
                            ),
                            if (!isVisible)
                              Column(
                                children: [SizedBox(height: 5.h),
                                  Text(
                                    LocaleKeys.auth_user_agreement_message.tr(),
                                    textAlign: TextAlign.center,
                                    style: context.textTheme.mainLight.copyWith(
                                        color: context.colors.accent
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: (){},
                                    child: Text(
                                      LocaleKeys.auth_user_agreement.tr(),
                                      style: context.textTheme.mainFat.copyWith(
                                          color: context.colors.shared.white
                                      ),
                                    ),
                                  )
                                ],
                              )
                          ],
                        ),
                      ),
                    ),

                  ],
                );
              },
            );
          }
      )
    );
  }

}