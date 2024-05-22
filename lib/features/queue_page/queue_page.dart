import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:student_helper/common/domain/state/profile_info/profile_info_controller.dart';
import 'package:student_helper/common/domain/state/queue/queue_controller.dart';
import 'package:student_helper/common/utils/context_extensions.dart';
import 'package:student_helper/features/queue_page/widget/queue_element_widget.dart';
import 'package:student_helper/features/widgets/custom_buttons.dart';

import '../../common/domain/model/profile_info/profile_info.dart';
import '../../common/domain/model/queue_element/queue_element.dart';
import '../../generated/locale_keys.g.dart';
import '../widgets/custom_app_bar.dart';

class QueuePage extends HookConsumerWidget {

  final String queueId;
  final String title;

  QueuePage({
    super.key,
    required this.queueId,
    required this.title
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final state = ref.watch(queueControllerProvider(queueId));
    final profileState = ref.read(profileInfoControllerProvider);

    return Scaffold(
      appBar: CAppBar(
          title: Text(
              title,
              style: context.textTheme.header1.copyWith(
                  color: context.colors.accent)
          )
      ),
      body: getBody(context, state, ref, profileState),
    );
  }

  Widget getBody(
      BuildContext context,
      AsyncValue<Queue> state,
      WidgetRef ref,
      AsyncValue<ProfileInfo> profileState
      ) {

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

    final queue = state.value!.queueList;
    final profile = profileState.value!;

    final isInQueue = useState(queue.where((element) => element.userId == profile.userId).isNotEmpty);

    return RefreshIndicator(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 200.h),
              child: ListView.separated(
                  padding: EdgeInsets.only(top: 24.h, left: 23.w, right: 23.w),
                  itemBuilder: (context, index) {
                    return QueueElementWidget(
                        name: queue[index].userName,
                        index: queue[index].index,
                        isOwner: queue[index].userId == profile.userId
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 14.h);
                  },
                  itemCount: queue.length
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(left: 40.w, bottom: 40.h, right: 40.w),
                child: CButton.primary(
                    context: context,
                    label: isInQueue.value
                      ? LocaleKeys.queue_leave_queue.tr()
                      : LocaleKeys.queue_enter_queue.tr(),
                    onTap: () {
                        isInQueue.value = !isInQueue.value;
                    }
                ),
              ),
            )
          ],
        ),
        onRefresh: () async {
          ref.invalidate(queueControllerProvider(queueId));
        }
    );
  }

}