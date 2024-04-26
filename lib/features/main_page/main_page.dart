import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:student_helper/common/domain/state/main_item/main_item_controller.dart';
import 'package:student_helper/features/main_page/widget/main_item_widget.dart';
import 'package:student_helper/features/widgets/empty_widget.dart';

import '../../generated/assets.gen.dart';
import '../../generated/locale_keys.g.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mainItemControllerProvider);

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
            return MainItemWidget(
                type: state.value![index].type,
                title: state.value![index].title,
                color: state.value![index].color
            );
          },
          separatorBuilder: (context, index){
            return SizedBox(height: 20.h);
          },
          itemCount: state.value!.length
      ),
    );

  }

}