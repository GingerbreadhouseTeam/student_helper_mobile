import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:student_helper/common/domain/model/main_item/main_item.dart';
import 'package:student_helper/common/utils/context_extensions.dart';

import '../../../common/utils/color_types.dart';
import '../../../generated/assets.gen.dart';

class MainItemWidget extends HookConsumerWidget {

  final MainItemType type;
  final String title;
  final ItemColor color;
  final VoidCallback onTap;

  MainItemWidget({
    super.key,
    required this.type,
    required this.title,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: context.colors.secondary,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 11.w,
            right: 10.w
          ),
          child: Stack(
            children: [
              Row(
                children: [
                  getLeading(color, type, context),
                  SizedBox(width: 14.w),
                  Expanded(child: Text(
                    title,
                    style: context.textTheme.header2.copyWith(
                      color: context.colors.shared.white
                    ),
                  )),
                  SizedBox(width: 3.w),

                ],
              ),
              Positioned(
                  top: 10.h,
                  right: 0,
                  child: Container(
                    width: 14.h,
                    height: 14.h,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: getColor(color, context)
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getLeading(
      ItemColor colorType,
      MainItemType type,
      BuildContext context,
      ) {
    final color = getColor(colorType, context);
    switch (type){
      case MainItemType.order:
        return Container(
          width: 18.w,
          color: color,
          child: Padding(
            padding: EdgeInsets.only(top: 10.h, bottom: 2.h),
            child: SizedBox(
              width: 20.w,
              height: 72.h,
              child: Assets.images.people.svg(),
            ),
          ),
        );
      default:
        return SizedBox(
          width: 18.w,
          height: 78.h,
          child: Assets.images.bookmark.svg(
            colorFilter: ColorFilter.mode(
                color,
                BlendMode.srcIn
            )
          ),
        );
    }
  }



}