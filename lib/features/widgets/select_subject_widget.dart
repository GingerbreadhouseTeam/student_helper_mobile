import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:student_helper/common/domain/model/subject_preview/subject_preview.dart';
import 'package:student_helper/common/utils/context_extensions.dart';

import '../../common/utils/color_types.dart';
import '../../generated/assets.gen.dart';
import '../../generated/locale_keys.g.dart';

class SelectSubjectWidget extends HookConsumerWidget {

  final ExpansionTileController tileController;
  final SubjectPreview? subjectPreview;
  final ValueNotifier<SubjectPreview?> selectedSubjectPreview;
  final ValueNotifier<List<SubjectPreview>?> subjects;

  SelectSubjectWidget({
    super.key,
    required this.tileController,
    required this.subjectPreview,
    required this.selectedSubjectPreview,
    required this.subjects
  });



  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return ExpansionTile(
      controller: tileController,
      backgroundColor: context.colors.secondary,
      collapsedBackgroundColor: context.colors.secondary,
      enabled: subjectPreview == null,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: context.colors.accent, width: 1.w)
      ),
      collapsedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
      ),
      title: selectedSubjectPreview.value != null
          ? Row(
        children: [
          Container(
            width: 12.h,
            height: 12.h,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: getColor(selectedSubjectPreview.value!.color, context)
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            selectedSubjectPreview.value!.title,
            style: context.textTheme.form.copyWith(
                color: context.colors.accent
            ),
          )
        ],
      )
          : Text(
        LocaleKeys.subjects_subject.tr(),
        style: context.textTheme.mainLight.copyWith(
            color: context.colors.accent50
        ),

      ),
      trailing: SizedBox(
        width: 24.h,
        height: 24.h,
        child: Assets.images.icSelect.svg(),
      ),
      children: _createTiles(context, subjects.value!, selectedSubjectPreview, tileController),
    );

  }

  List<Widget> _createTiles(BuildContext context,
      List<SubjectPreview> subjects,
      ValueNotifier<SubjectPreview?> selected,
      ExpansionTileController tileController
      ) {
    List<Widget> tiles = [];
    for (int i = 0; i < subjects.length; i++) {
      if((selected.value != null && selected.value!.id != subjects[i].id) || selected.value == null){
        tiles.add(
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
              child: GestureDetector(
                child: Row(
                  children: [
                    Container(
                      width: 12.h,
                      height: 12.h,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: getColor(subjects[i].color, context)
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      subjects[i].title,
                      style: context.textTheme.button.copyWith(
                          color: context.colors.shared.white
                      ),
                    )
                  ],
                ),
                onTap: () {
                  selected.value = subjects[i];
                  tileController.collapse();
                },
              ),
            )
        );
      }

    }
    return tiles;
  }


}