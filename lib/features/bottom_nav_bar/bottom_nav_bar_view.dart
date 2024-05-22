import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:student_helper/common/data/repository/auth_repository/auth_repository.dart';
import 'package:student_helper/common/utils/context_extensions.dart';
import 'package:student_helper/features/bottom_nav_bar/widget/bottom_nav_bar_item.dart';
import 'package:student_helper/features/widgets/custom_app_bar.dart';

import '../../generated/assets.gen.dart';
import '../../generated/locale_keys.g.dart';

class BottomNavBarView extends HookConsumerWidget {
  const BottomNavBarView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabPage = TabPage.of(context);

    return Scaffold(
      appBar: getCanPop(context)
        ? null
        : CAppBar(
          actions: [
            InkWell(
              onTap: () {
                //TODO убрать эту грязь надо бы...
                ref.read(authRepositoryProvider).logout();
              },
              child: SizedBox(
                width: 44.h,
                height: 44.h,
                child: Assets.images.icUser.svg(),
              ),
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
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: context.colors.tertiary,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
          )
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 23.w),
          child: Row(
            children: [
              BottomNavBarItem(
                  image: Assets.images.icHome.svg(),
                  isSelected: tabPage.index == 0,
                  onTap: () {
                    if (getCanPop(context)) {
                      Routemaster.of(context).pop();
                      tabPage.controller.animateTo(0, duration: const Duration(seconds: 0));
                    } else {

                      tabPage.controller.animateTo(0);
                    }
                  }
              ),
              BottomNavBarItem(
                  image: Assets.images.icBook.svg(),
                  isSelected: tabPage.index == 1,
                  onTap: () {
                    if (getCanPop(context)) {
                      Routemaster.of(context).pop();
                      tabPage.controller.animateTo(1, duration: const Duration(seconds: 0));
                    } else {
                      tabPage.controller.animateTo(1);
                    }
                  }
              ),
              BottomNavBarItem(
                  image: Assets.images.icCalendar.svg(),
                  isSelected: tabPage.index == 2,
                  onTap: () {
                    if (getCanPop(context)) {
                      Routemaster.of(context).pop();
                      tabPage.controller.animateTo(2, duration: const Duration(seconds: 0));
                    } else {
                      tabPage.controller.animateTo(2);
                    }
                  }
              )
            ],
          ),
        ),
      ),

    );


  }

  bool getCanPop(BuildContext context) {
    final canPopRoutes = ['/main/topic', '/main/queue'];
    final currentRoute = Routemaster.of(context).currentRoute;
    if (canPopRoutes.contains(currentRoute.path)){
      return true;
    }
    return false;

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