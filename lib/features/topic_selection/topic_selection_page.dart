import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:student_helper/common/domain/model/profile_info/profile_info.dart';
import 'package:student_helper/common/domain/state/profile_info/profile_info_controller.dart';
import 'package:student_helper/common/domain/state/topic_selection_element/topic_selection_element_controller.dart';
import 'package:student_helper/common/utils/color_types.dart';
import 'package:student_helper/common/utils/context_extensions.dart';
import 'package:student_helper/features/topic_selection/widgets/topic_create_widget.dart';
import 'package:student_helper/features/topic_selection/widgets/topic_edit_assign_widget.dart';
import 'package:student_helper/features/widgets/custom_bottom_sheet.dart';
import 'package:student_helper/features/widgets/element_add_widget.dart';
import 'package:student_helper/features/topic_selection/widgets/topic_selection_element_widget.dart';
import 'package:student_helper/features/widgets/custom_app_bar.dart';

import '../../generated/assets.gen.dart';

class TopicSelectionPage extends HookConsumerWidget {

  final String topicId;
  final String title;

  TopicSelectionPage({super.key, required this.topicId, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(topicSelectionElementControllerProvider(topicId));
    final topicColor = useState(ItemColor.white);

    return Scaffold(
      appBar: CAppBar(
          title: Text(
              title,
              style: context.textTheme.header1.copyWith(
                  color: context.colors.accent)
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 25.w),
              child: SizedBox(
                width: 18.w,
                height: 50.h,
                child: Assets.images.bookmark.svg(),
              ),
            )
          ],
      ),
      floatingActionButton: (state.value?.topics.length ?? 0) > 6
        ? IconButton(
          onPressed: () {
            CBottomSheet.show(
                context,
                useRootNavigator: true,
                child: TopicCreateEditWidget(
                    onCreateTap: (String content, bool isAssignToMe) {

                    }
                )
            );
          },
          icon: Assets.images.icPlus.svg()
      )
          : null,
      body: state.when(
          data: (data) {
            return ListView.separated(
              padding: EdgeInsets.only(top: 35.h, left: 25.w, right: 25.w, bottom: 5.h),
                itemBuilder: (innerContext, index) {
                  if (index == data.topics.length) {
                    return ElementAddWidget(
                      onTap: () {
                        CBottomSheet.show(
                            context,
                            useRootNavigator: true,
                            child: TopicCreateEditWidget(
                                onCreateTap: (String content, bool isAssignToMe) {

                                }
                            )
                        );
                      },
                    );
                  }
                  final isOwned = ref
                      .read(profileInfoControllerProvider)
                      .value?.userId == data.topics[index].userId;
                  final isHeadman = ref
                      .read(profileInfoControllerProvider)
                      .value!.role != UserRole.student;
                  return TopicSelectionElementWidget(
                    index: data.topics[index].index,
                    topicTitle: data.topics[index].topicName,
                    isOwner: isOwned,
                    isHeadman: isHeadman,
                    topicName: data.topics[index].userName,
                    onSignTap: () {
                      CBottomSheet.show(
                          context,
                          useRootNavigator: true,
                          child: TopicEditAssignWidget(
                              onConfirmTap: (String content, bool isAssignToMe) {
                              },
                              initialValue: data.topics[index].topicName,
                              isOwned: isOwned,
                              isHeadman: isHeadman,
                              isOwnedBySomeone: (data.topics[index].userName != null) && !isOwned,

                          )
                      );
                    },
                  );
                },
                separatorBuilder: (innerContext, index) {
                  return SizedBox(height: 8.h);
                },
                itemCount: data.topics.length + 1
            );
          },
          error: (error, stackTrace) {
            return Text("Ошибаешься... \n и вот почему \n ${error} \n${stackTrace}");
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
      ),
    );


  }

}