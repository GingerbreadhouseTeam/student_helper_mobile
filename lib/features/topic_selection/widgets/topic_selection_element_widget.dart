import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:student_helper/common/utils/context_extensions.dart';

import '../../../generated/assets.gen.dart';

class TopicSelectionElementWidget extends HookConsumerWidget {

  final int index;
  final String topicTitle;
  final String? topicName;
  final bool isOwner;
  final VoidCallback? onSignTap;
  final VoidCallback? onOwnerTap;

  TopicSelectionElementWidget({
    super.key,
    required this.index,
    required this.topicTitle,
    required this.isOwner,
    this.topicName,
    this.onSignTap,
    this.onOwnerTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    print(isOwner);

    return Container(
      constraints: BoxConstraints(
        minHeight: 78.h
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: context.colors.secondary
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 12.w),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                index.toString(),
                style: context.textTheme.main.copyWith(
                  color: context.colors.shared.white
                ),
              ),
              SizedBox(width: 12.w),
              Container(
                width: 1.w,
                color: context.colors.coldGrey,
              ),
              topicName == null
                  ? Expanded(child: getUnoccupiedTopicWidget(context, topicTitle))
                  : Expanded(child: getOccupiedTopicWidget(context, topicTitle, topicName!, isOwner))
            ],
          ),
        ),
      ),
    );
  }

  Widget getUnoccupiedTopicWidget(
      BuildContext context,
      String title
      ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 21.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.mainFat.copyWith(
                color: context.colors.shared.white
              ),
            ),
          ),
          SizedBox(width: 2.w),
          InkWell(
            child: SizedBox(
              height: 24.h,
              width: 24.h,
              child: Assets.images.icEdit.svg(),
            ),
          )
        ],
      ),
    );
  }

  Widget getOccupiedTopicWidget(
      BuildContext context,
      String title,
      String name,
      bool isOwner
      ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.mainFat.copyWith(
                color: context.colors.shared.white
              ),
            ),
          ),
          SizedBox(height: 11.h),
          Container(
            height: 1.h,
            color: context.colors.coldGrey,
          ),
          SizedBox(height: 11.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.h),
            child: Row(
              children: [
                Expanded(
                    child: Text(
                      name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.mainLight.copyWith(
                        color: context.colors.shared.white
                      ),
                    )
                ),
                SizedBox(width: 9.w),
                if (isOwner)
                  SizedBox(
                    height: 18.h,
                    width: 18.h,
                    child: Assets.images.icClose.svg(),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }



}