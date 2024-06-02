import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:student_helper/common/utils/context_extensions.dart';

import '../../../generated/assets.gen.dart';
import '../../../generated/locale_keys.g.dart';
import '../../widgets/custom_buttons.dart';

class QueueTypeEditWidget extends HookConsumerWidget {

  final bool isCyclic;

  QueueTypeEditWidget({
    super.key,
    required this.isCyclic
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final enabled = useState(isCyclic);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          LocaleKeys.queue_queue_type.tr(),
          style: context.textTheme.header2.copyWith(
            color: context.colors.accent
          ),
        ),
        SizedBox(height: 14.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.queue_sequential.tr(),
                  style: context.textTheme.main.copyWith(
                    color: context.colors.shared.white
                  ),
                ),
                SizedBox(
                  width: 25.h,
                  height: 25.h,
                  child: Assets.images.icSequentialQueue.svg(),
                )
              ],
            ),
            SizedBox(width: 13.w),
            FlutterSwitch(
                value: enabled.value,
                width: 38.w,
                height: 17.h,
                padding: 0,
                toggleColor: context.colors.accent,
                activeColor: context.colors.accent50,
                inactiveColor: context.colors.secondary,
                toggleSize: 17.h,
                onToggle: (bool value) {
                  enabled.value = value;
                }
            ),
            SizedBox(width: 13.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  LocaleKeys.queue_cyclic.tr(),
                  style: context.textTheme.main.copyWith(
                      color: context.colors.shared.white
                  ),
                ),
                SizedBox(
                  width: 25.h,
                  height: 25.h,
                  child: Assets.images.icCyclicQueue.svg(),
                )
              ],
            ),
          ],
        ),
        SizedBox(height: 14.h),
        CButton.primary(
            context: context,
            label: LocaleKeys.queue_close_queue.tr(),
            onTap: (){
              Navigator.of(context).pop();
            }
        )
      ],
    );
  }

}