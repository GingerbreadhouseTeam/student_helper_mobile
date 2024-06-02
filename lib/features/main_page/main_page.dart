import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:student_helper/common/domain/model/main_item/main_item.dart';
import 'package:student_helper/common/domain/model/profile_info/profile_info.dart';
import 'package:student_helper/common/domain/state/main_item/main_item_controller.dart';
import 'package:student_helper/common/domain/state/profile_info/profile_info_controller.dart';
import 'package:student_helper/common/utils/context_extensions.dart';
import 'package:student_helper/features/main_page/widget/create_queue_topic_widget.dart';
import 'package:student_helper/features/main_page/widget/main_item_widget.dart';
import 'package:student_helper/features/widgets/custom_bottom_sheet.dart';
import 'package:student_helper/features/widgets/element_add_widget.dart';
import 'package:student_helper/features/widgets/empty_widget.dart';

import '../../generated/assets.gen.dart';
import '../../generated/locale_keys.g.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mainItemControllerProvider);
    final profileState = ref.watch(profileInfoControllerProvider);

    if (state is AsyncLoading && !state.hasValue){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (state is AsyncError && !state.hasValue){
      return Center(
        child: Text(
          "Ошибка ${state.error}"
        ),
      );
    }

    if (state is AsyncData && state.value!.isEmpty){
      return EmptyWidget(
          text: LocaleKeys.main_empty.tr(),
          picture: Assets.images.emptyCatPng.image(),
      );
    }

    if (profileState is AsyncLoading && !profileState.hasValue){
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    if (profileState is AsyncError && !profileState.hasValue){
      return Center(
        child: Text(
            "Ошибка ${state.error}"
        ),
      );
    }

    if (profileState is AsyncData && profileState.hasValue && state is AsyncData && !state.hasValue) {
      return Padding(
        padding: EdgeInsets.symmetric(vertical: 35.h, horizontal: 25.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.main_here_you_can_find.tr(),
              style: context.textTheme.header2.copyWith(
                color: context.colors.shared.white
              ),
            ),
            SizedBox(height: 35.h),
            ElementAddWidget(
                onTap: () {
                  CBottomSheet.show(context,
                      useRootNavigator: true,
                      child: CreateQueueTopicWidget()
                  );
                }
            )
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(mainItemControllerProvider);
      },
      child: ListView.separated(
          padding: EdgeInsets.only(
            left: 25.w,
            right: 25.w,
            top: 36.h,
            bottom: 36.h
          ),
          itemBuilder: (context, index) {
            if (index == state.value!.length && profileState.value!.role != UserRole.student && state.value!.isNotEmpty) {
              return ElementAddWidget(
                  onTap: () {
                    CBottomSheet.show(context,
                        useRootNavigator: true,
                        child: CreateQueueTopicWidget()
                    );
                  }
              );
            }
            return MainItemWidget(
                type: state.value![index].type,
                title: state.value![index].title,
                color: state.value![index].color,
                onTap: () {
                  print(state.value![index].type);

                  switch (state.value![index].type) {
                    case MainItemType.theme: Routemaster.of(context).push('topic', queryParameters: {
                      'id': "3",
                      'title': state.value![index].title
                    });
                    case MainItemType.order: Routemaster.of(context).push('queue', queryParameters: {
                      'id': "3",
                      'title': state.value![index].title
                    });
                    default: Routemaster.of(context).push('topic', queryParameters: {
                      'id': "3",
                      'title': state.value![index].title
                    });
                  }


                },
            );
          },
          separatorBuilder: (context, index){
            return SizedBox(height: 20.h);
          },
          itemCount: state.value!.length + 1
      ),
    );

  }

}