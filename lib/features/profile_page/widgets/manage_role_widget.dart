import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:student_helper/common/utils/context_extensions.dart';

import '../../../generated/locale_keys.g.dart';

class ManageRoleWidget extends HookConsumerWidget {
  final VoidCallback onAssignCoHeadmanTap;
  final VoidCallback onDemoteCoHeadmanTap;
  final VoidCallback onRetireTap;

  ManageRoleWidget(
      {super.key, required this.onAssignCoHeadmanTap, required this.onDemoteCoHeadmanTap, required this.onRetireTap});

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
        LocaleKeys.profile_role_management.tr(),
        style: context.textTheme.header2.copyWith(color: context.colors.shared.white),
      ),
      onExpansionChanged: (expansion) {
        expanded.value = expansion;
      },
      children: [
        ListTile(
            onTap: onAssignCoHeadmanTap,
            title: Text(
              LocaleKeys.profile_assign_co_headman.tr(),
              style: context.textTheme.header2.copyWith(
                color: context.colors.shared.white
              ),
            )
        ),
        ListTile(
            onTap: onDemoteCoHeadmanTap,
            title: Text(
              LocaleKeys.profile_demote_co_headman.tr(),
              style: context.textTheme.header2.copyWith(
                  color: context.colors.shared.white
              ),
            )
        ),
        ListTile(
            onTap: onRetireTap,
            title: Text(
              LocaleKeys.profile_retire.tr(),
              style: context.textTheme.header2.copyWith(
                  color: context.colors.shared.white
              ),
            )
        ),
      ],
    );
  }
}
