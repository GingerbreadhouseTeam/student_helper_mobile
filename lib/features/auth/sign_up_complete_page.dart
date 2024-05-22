import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:student_helper/common/utils/context_extensions.dart';

import '../../generated/assets.gen.dart';
import '../../generated/locale_keys.g.dart';
import '../widgets/custom_buttons.dart';

class SignUpCompletePage extends HookConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taps = useState(0);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 52.h, left: 24.w, right: 24.w, bottom: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.auth_sign_up_complete.tr(),
              style: context.textTheme.header1.copyWith(
                color: context.colors.accent
              ),
            ),
            SizedBox(height: 72.h),
            GestureDetector(
              onTap: () {
                taps.value++;
                if (taps.value == 5) {
                  Routemaster.of(context).push('special_thanks');
                }
              },
              child: SizedBox(
                width: 312.h,
                height: 312.h,
                child: Assets.images.scaryFace.image()
              ),
            ),
            SizedBox(height: 32.h),
            Text(
              LocaleKeys.auth_confirm_email.tr(),
              style: context.textTheme.mainLight.copyWith(
                color: context.colors.accent
              ),
            ),
            SizedBox(height: 50.h),
            CButton.primary(
                context: context,
                label: LocaleKeys.auth_confirm.tr(),
                onTap: () {
                  Routemaster.of(context).push('/sign_in');
                }
            )
          ],
        ),
      ),
    );
  }

}