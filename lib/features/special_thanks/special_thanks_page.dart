import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:student_helper/common/utils/context_extensions.dart';
import 'package:student_helper/features/widgets/custom_buttons.dart';

import '../../generated/assets.gen.dart';

class SpecialThanksPage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              textAlign: TextAlign.center,
              "Отдельная благодарность\nза внесенный неоценимый вклад в проект",
              style: context.textTheme.header1.copyWith(
                color: context.colors.shared.white
              ),
            ),
            SizedBox(height: 20.h),
            SizedBox(
              height: 160.h,
              width: 160.h,
              child: Assets.images.specialThanks.image(),
            ),
            SizedBox(height: 30.h),
            Text(
                "Якуниной К.В.",
            ),
            SizedBox(height: 100.h),
            CButton.primary(
                context: context,
                label: "Спасибо!",
                onTap: () {
                  Routemaster.of(context).pop();
                }
            )
          ],
        ),
      ),
    );
  }

}