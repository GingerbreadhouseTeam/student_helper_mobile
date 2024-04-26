import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:student_helper/common/utils/context_extensions.dart';
import 'package:student_helper/features/widgets/custom_app_bar.dart';

import '../../generated/assets.gen.dart';
import '../../generated/locale_keys.g.dart';

class BottomNavBarView extends HookConsumerWidget {
  const BottomNavBarView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabPage = TabPage.of(context);

    return Scaffold(
      appBar: CAppBar(
        actions: [
          SizedBox(
            width: 44.h,
            height: 44.h,
            child: Assets.images.icUser.svg(),
          )
        ],
        title: Text(
            getTitle(tabPage.index),
            style: context.textTheme.header1.copyWith(
              color: context.colors.accent
            ),
        )
      ),
      body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: tabPage.controller,
          children: [for (final stack in tabPage.stacks) PageStackNavigator(stack: stack)]
      ),

    );


  }

  String getTitle(index) {
    switch (index) {
      case 0:
        return LocaleKeys.main_title.tr();
      case 1:
        return LocaleKeys.subjects_title.tr();
      case 2:
        return LocaleKeys.schedule_title.tr();
      default:
        return "";
    }
  }

}