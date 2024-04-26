import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:student_helper/common/utils/context_extensions.dart';

class EmptyWidget extends HookConsumerWidget{

  final String text;
  final Image? picture;

  EmptyWidget({
    super.key,
    required this.text,
    this.picture
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
        padding: EdgeInsets.only(
          top: 35.h,
          left: 22.w,
          right: 22.w,
          bottom: 134.h,
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            text,
            style: context.textTheme.header2.copyWith(
              color: context.colors.accent
            ),
          ),
          SizedBox(height: 68.h),
          SizedBox(
            height: 335.h,
            width: 335.h,
            child: picture,
          )
        ],
      ),
    );
  }

}