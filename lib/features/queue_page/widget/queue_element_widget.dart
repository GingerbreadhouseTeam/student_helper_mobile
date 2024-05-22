import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:student_helper/common/utils/context_extensions.dart';

class QueueElementWidget extends HookConsumerWidget {

  final String name;
  final int index;
  final bool isOwner;

  QueueElementWidget({
    super.key,
    required this.name,
    required this.index,
    required this.isOwner
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isOwner
            ? context.colors.accent50
            : context.colors.secondary
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 17.w, vertical: 10.h),
        child: Row(
          children: [
            Text(
              index.toString(),
              style: context.textTheme.form.copyWith(
                color: isOwner
                    ? context.colors.secondary
                    : context.colors.shared.white
              ),
            ),
            Expanded(
                child: Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: context.textTheme.form.copyWith(
                      color: isOwner
                          ? context.colors.secondary
                          : context.colors.shared.white
                  ),
                )
            )
          ],
        ),
      ),
    );
  }

}