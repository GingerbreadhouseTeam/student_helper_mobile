import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:student_helper/common/domain/model/main_item/main_item.dart';
import 'package:student_helper/common/domain/state/main_item/main_item_controller.dart';
import 'package:student_helper/common/domain/state/profile_info/profile_info_controller.dart';
import 'package:student_helper/common/domain/state/queue/queue_controller.dart';
import 'package:student_helper/common/utils/context_extensions.dart';
import 'package:student_helper/features/queue_page/widget/queue_element_widget.dart';
import 'package:student_helper/features/queue_page/widget/queue_type_edit_widget.dart';
import 'package:student_helper/features/widgets/custom_bottom_sheet.dart';
import 'package:student_helper/features/widgets/custom_buttons.dart';

import '../../common/domain/model/profile_info/profile_info.dart';
import '../../common/domain/model/queue_element/queue_element.dart';
import '../../common/utils/color_types.dart';
import '../../generated/assets.gen.dart';
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


    final profile = profileState.value!;
    final queueColor = useState(getColor(ItemColor.white, context));

    return Scaffold(
      appBar: CAppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: profile.role != UserRole.student
                ? 2.w
                : 27.w
            ),
            child: Container(
              width: 18.w,
              height: 50.h,
              color: queueColor.value,
              child: Assets.images.peopleSmall.svg(),
            ),
          ),
          if (profile.role != UserRole.student)
            InkWell(
            onTap: (){
              CBottomSheet.show(
                  context,
                  useRootNavigator: true,
                  child: QueueTypeEditWidget(
                    isCyclic: state.value!.queueType == QueueType.cyclic,
                  )
              );
            },
            borderRadius: BorderRadius.circular(90),
            child: SizedBox(
              width: 24.h,
              height: 24.h,
              child: Assets.images.icEdit.svg(
                colorFilter: ColorFilter.mode(
                    context.colors.accent,
                    BlendMode.srcIn
                )
              ),
            ),
          )
        ],
          title: Text(
              title,
              style: context.textTheme.header1.copyWith(
                  color: context.colors.accent)
          )
      ),
      body: getBody(context, state, ref, profileState, queueColor),
    );
  }

  Widget getBody(
      BuildContext context,
      AsyncValue<Queue> state,
      WidgetRef ref,
      AsyncValue<ProfileInfo> profileState,
      ValueNotifier<Color> queueColor,
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
    
    queueColor.value = getColor(state.value!.queueColor, context);

    return RefreshIndicator(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 62.w,
                  height: 17.h,
                  child: state.value!.queueType == QueueType.cyclic
                    ? Assets.images.queueTypeCyclic.svg()
                    : Assets.images.queueTypeSequential.svg(),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 200.h),
                  child: ListView.separated(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 18.h, left: 23.w, right: 23.w),
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
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(left: 40.w, bottom: 40.h, right: 40.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (state.value!.queueType == QueueType.cyclic && isInQueue.value)
                      Padding(
                        padding: EdgeInsets.only(bottom: 25.h),
                        child: CButton.primary(
                            context: context,
                            label: LocaleKeys.queue_re_enter_queue.tr(),
                            onTap: () {}
                        ),
                      ),
                    CButton.primary(
                        context: context,
                        label: isInQueue.value
                          ? LocaleKeys.queue_leave_queue.tr()
                          : LocaleKeys.queue_enter_queue.tr(),
                        onTap: () {

                            if (isInQueue.value) {
                              ref.read(queueControllerProvider(queueId).notifier).deleteUserFromQueue(
                                  queueId: queueId,
                                  userId: profile.userId,
                                  index: 1,
                                  userName: profile.name
                              );
                            } else {
                              ref.read(queueControllerProvider(queueId).notifier).addUserToQueue(
                                  queueId: queueId,
                                  userId: profile.userId,
                                  index: 1,
                                  userName: profile.name);
                            }

                            isInQueue.value = !isInQueue.value;
                        }
                    ),
                  ],
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