import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:student_helper/common/utils/context_extensions.dart';

import '../../../common/domain/model/profile_info/profile_info.dart';
import '../../../generated/locale_keys.g.dart';

class GroupSettingsWidget extends HookConsumerWidget {

  final UserRole role;
  final VoidCallback onValidateScheduleTap;
  final VoidCallback onWatchCodeTap;
  final VoidCallback onKickTap;
  final VoidCallback onLeaveGroupTap;

  GroupSettingsWidget({
    super.key,
    required this.role,
    required this.onValidateScheduleTap,
    required this.onWatchCodeTap,
    required this.onKickTap,
    required this.onLeaveGroupTap
  });


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final expanded = useState(false);

    return ExpansionTile(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
      ),
      collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
      ),
      backgroundColor: context.colors.secondary,
      collapsedBackgroundColor: context.colors.secondary,
      iconColor: context.colors.coldGrey,
      collapsedIconColor: context.colors.coldGrey,
      controlAffinity: ListTileControlAffinity.leading,
      expandedCrossAxisAlignment: CrossAxisAlignment.center,
      leading: Icon(
          size: 24.h,
          expanded.value
              ? Icons.arrow_drop_down
              : Icons.arrow_right),
      title: Text(
        LocaleKeys.profile_group_settings.tr(),
        style: context.textTheme.header2.copyWith(color: context.colors.shared.white),
      ),
      onExpansionChanged: (expansion) {
        expanded.value = expansion;
      },
      children: [
        if (role != UserRole.student)
          ListTile(
              onTap: onValidateScheduleTap,
              title: Text(
                LocaleKeys.profile_validate_schedule.tr(),
                style: context.textTheme.header2.copyWith(
                    color: context.colors.shared.white
                ),
              )
          ),
        ListTile(
            onTap: onWatchCodeTap,
            title: Text(
              LocaleKeys.profile_look_at_unique_code.tr(),
              style: context.textTheme.header2.copyWith(
                  color: context.colors.shared.white
              ),
            )
        ),
        if (role != UserRole.student)
          ListTile(
              onTap: onKickTap,
              title: Text(
                LocaleKeys.profile_kick_from_group.tr(),
                style: context.textTheme.header2.copyWith(
                    color: context.colors.shared.white
                ),
              )
          ),
        ListTile(
            onTap: onLeaveGroupTap,
            title: Text(
              LocaleKeys.profile_leave_group.tr(),
              style: context.textTheme.header2.copyWith(
                  color: context.colors.shared.white
              ),
            )
        ),
      ],
    );
  }
}
