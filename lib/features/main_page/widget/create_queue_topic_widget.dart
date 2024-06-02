import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:student_helper/common/domain/model/queue_element/queue_element.dart';
import 'package:student_helper/common/domain/state/subject_preview/subject_preview_controller.dart';
import 'package:student_helper/common/utils/context_extensions.dart';
import 'package:student_helper/features/widgets/select_subject_widget.dart';

import '../../../common/domain/model/subject_preview/subject_preview.dart';
import '../../../generated/assets.gen.dart';
import '../../../generated/locale_keys.g.dart';
import '../../widgets/custom_buttons.dart';

class CreateQueueTopicWidget extends HookConsumerWidget {

  final nameControl = FormControl(
      validators: [
        Validators.required,
      ]
  );

  late final form = FormGroup(
      {"nameControl": nameControl}
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final isTopicCreation = useState(false);
    final tileController = useExpansionTileController();
    final queueTypeTileController = useExpansionTileController();
    final selectedSubjectPreview = useState<SubjectPreview?>(null);
    final subjects = useState<List<SubjectPreview>>([]);

    final subjectState = ref.watch(subjectPreviewControllerProvider);
    final formValid = useState(form.valid);

    final selectedQueueType = useState<QueueType?>(null);

    return subjectState.when(
        data: (data) {
          subjects.value = data;
          return ReactiveFormBuilder(
            form: () => form,
            builder: (context, form, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    LocaleKeys.create.tr(),
                    style: context.textTheme.header2.copyWith(
                        color: context.colors.shared.white
                    ),
                  ),
                  SizedBox(height: 22.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.queue_word.tr(),
                        style: context.textTheme.header2.copyWith(
                            color: context.colors.shared.white
                        ),
                      ),
                      FlutterSwitch(
                          value: isTopicCreation.value,
                          width: 38.w,
                          height: 17.h,
                          padding: 0,
                          toggleColor: context.colors.accent,
                          activeColor: context.colors.accent50,
                          inactiveColor: context.colors.secondary,
                          toggleSize: 17.h,
                          onToggle: (bool value) {
                            isTopicCreation.value = value;
                          }
                      ),
                      Text(
                        LocaleKeys.topic_selection.tr(),
                        style: context.textTheme.header2.copyWith(
                            color: context.colors.shared.white
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 25.h),
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 98.h),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ReactiveTextField(
                              formControlName: 'nameControl',
                              onChanged: (control) {
                                formValid.value = control.valid;
                              },
                              decoration: InputDecoration(
                                hintText: LocaleKeys.subjects_name.tr()
                              ),
                            ),
                            SizedBox(height: !isTopicCreation.value ? 28.h : 0),
                            if (!isTopicCreation.value)
                              ExpansionTile(
                              controller: queueTypeTileController,
                              backgroundColor: context.colors.secondary,
                              collapsedBackgroundColor: context.colors.secondary,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(color: context.colors.accent, width: 1.w)
                              ),
                              collapsedShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)
                              ),
                              title:

                              selectedQueueType.value == null
                                ? Text(
                                  LocaleKeys.queue_type.tr(),
                                  style: context.textTheme.mainLight.copyWith(
                                      color: context.colors.accent50
                                  ),

                                )
                                : Row(
                                children: [
                                  SizedBox(
                                    width: 25.h,
                                    height: 25.h,
                                    child: selectedQueueType.value == QueueType.sequential
                                        ? Assets.images.icSequentialQueue.svg()
                                        : Assets.images.icCyclicQueue.svg()
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    selectedQueueType.value == QueueType.sequential
                                      ? LocaleKeys.queue_sequential.tr()
                                      : LocaleKeys.queue_cyclic.tr(),
                                    style: context.textTheme.button.copyWith(
                                        color: context.colors.shared.white
                                    ),
                                  )
                                ],
                              ),
                              trailing: SizedBox(
                                width: 24.h,
                                height: 24.h,
                                child: Assets.images.icSelect.svg(),
                              ),
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: 10.w, top: 12.h),
                                  child: InkWell(
                                    onTap: () {
                                      selectedQueueType.value = QueueType.sequential;
                                      queueTypeTileController.collapse();
                                    },
                                    borderRadius: BorderRadius.circular(12),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 25.h,
                                          height: 25.h,
                                          child: Assets.images.icSequentialQueue.svg(),
                                        ),
                                        SizedBox(width: 8.w),
                                        Text(
                                          LocaleKeys.queue_sequential.tr(),
                                          style: context.textTheme.button.copyWith(
                                            color: context.colors.shared.white
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.w, top: 10.h, bottom: 15.h),
                                  child: InkWell(
                                    onTap: () {
                                      selectedQueueType.value = QueueType.cyclic;
                                      queueTypeTileController.collapse();
                                    },
                                    borderRadius: BorderRadius.circular(12),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: 25.h,
                                          height: 25.h,
                                          child: Assets.images.icCyclicQueue.svg(),
                                        ),
                                        SizedBox(width: 8.w),
                                        Text(
                                          LocaleKeys.queue_cyclic.tr(),
                                          style: context.textTheme.button.copyWith(
                                              color: context.colors.shared.white
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 28.h),
                            CButton.primary(
                                context: context,
                                isEnabled: formValid.value && selectedSubjectPreview.value != null
                                    && ((!isTopicCreation.value && selectedQueueType.value != null) || isTopicCreation.value),
                                label: LocaleKeys.create.tr(),
                                onTap: () {}
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 22.h),
                        child: SelectSubjectWidget(
                            tileController: tileController,
                            subjectPreview: null,
                            selectedSubjectPreview: selectedSubjectPreview,
                            subjects: subjects
                        ),
                      )
                    ],
                  )
                ],
              );
            }
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