import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:student_helper/common/domain/state/profile_info/profile_info_controller.dart';
import 'package:student_helper/common/domain/state/topic_selection_element/topic_selection_element_controller.dart';
import 'package:student_helper/common/utils/context_extensions.dart';
import 'package:student_helper/features/topic_selection/widgets/topic_selection_element_add_widget.dart';
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

    return Scaffold(
      appBar: CAppBar(
          title: Text(
              title,
              style: context.textTheme.header1.copyWith(
                  color: context.colors.accent)
          )
      ),
      floatingActionButton: (state.value?.topics.length ?? 0) > 6
        ? IconButton(
          onPressed: () {},
          icon: Assets.images.icPlus.svg()
      )
          : null
      ,
      body: state.when(
          data: (data) {
            return ListView.separated(
              padding: EdgeInsets.only(top: 35.h, left: 25.w, right: 25.w, bottom: 5.h),
                itemBuilder: (innerContext, index) {
                  if (index == data.topics.length) {
                    return TopicSelectionElementAddWidget();
                  }
                  final isOwned = ref
                      .read(profileInfoControllerProvider)
                      .value?.userId == data.topics[index].userId;
                  return TopicSelectionElementWidget(
                    index: data.topics[index].index,
                    topicTitle: data.topics[index].topicName,
                    isOwner: isOwned,
                    topicName: data.topics[index].userName,
                    onSignTap: () {

                    },
                    onOwnerTap: () {

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