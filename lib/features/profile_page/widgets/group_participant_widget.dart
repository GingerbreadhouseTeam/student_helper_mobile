import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:student_helper/common/domain/model/profile_info/profile_info.dart';
import 'package:student_helper/common/domain/state/group_participant/group_participant_controller.dart';
import 'package:student_helper/common/utils/context_extensions.dart';
import 'package:student_helper/features/profile_page/widgets/participant_element_widget.dart';
import 'package:student_helper/features/widgets/custom_buttons.dart';

import '../../../generated/locale_keys.g.dart';

class GroupParticipantWidget extends HookConsumerWidget {

  final String title;
  final VoidCallback onConfirmTap;
  final String groupId;
  final bool isCoHeadman;

  GroupParticipantWidget({
    super.key,
    required this.title,
    required this.onConfirmTap,
    required this.groupId,
    required this.isCoHeadman
  });

  final FormGroup searchForm = FormGroup(
    {"search": FormControl<String>()}
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIds = useState(<String>[]);

    final state = ref.watch(groupParticipantControllerProvider(groupId));

    return state.when(
        data: (participants) {
          if (isCoHeadman) {
            participants = participants.where((element) => element.role == UserRole.coHeadman).toList();
          }
          return ReactiveFormBuilder(
            builder: (context, form, child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: context.textTheme.header1.copyWith(
                        color: context.colors.accent
                    ),
                  ),
                  SizedBox(height: 24.h),
                  ReactiveTextField(
                    formControlName: 'search',
                    onChanged: (form)  {
                      print('Changed!');
                      ref.read(groupParticipantControllerProvider(groupId).notifier).searchFilter(form.value.toString());
                    },
                    decoration: InputDecoration(
                        hintText: LocaleKeys.search.tr()
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(12)),
                        color: context.colors.secondary
                    ),
                    child: ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                        itemCount: participants.length,
                        itemBuilder: (context, index) {
                          return ParticipantElementWidgent(
                              isSelected: selectedIds.value.contains(participants[index].userId),
                              name: participants[index].name,
                              onTap: () {
                                if (selectedIds.value.contains(participants[index].userId)) {
                                  selectedIds.value = selectedIds
                                      .value.where((element) => element != participants[index].userId).toList();
                                } else {
                                  selectedIds.value = [...selectedIds.value, participants[index].userId];
                                }
                              }
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(height: 9.h);
              }
                    ),
                  ),
                  SizedBox(height: 24.h),
                  CButton.primary(
                      context: context,
                      label: LocaleKeys.confirm.tr(),
                      isEnabled: selectedIds.value.isNotEmpty,
                      onTap: onConfirmTap
                  ),
                ],
              );
            }, form: () => searchForm,
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
    );
  }

}