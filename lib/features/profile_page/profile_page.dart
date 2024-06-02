import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:student_helper/common/data/repository/auth_repository/auth_repository.dart';
import 'package:student_helper/common/data/repository/profile_info_repository/profile_info_repository.dart';
import 'package:student_helper/common/database/app_database.dart';
import 'package:student_helper/common/domain/model/profile_info/profile_info.dart';
import 'package:student_helper/common/domain/state/profile_info/profile_info_controller.dart';
import 'package:student_helper/common/utils/context_extensions.dart';
import 'package:student_helper/features/profile_page/widgets/group_participant_widget.dart';
import 'package:student_helper/features/profile_page/widgets/group_settings_widget.dart';
import 'package:student_helper/features/profile_page/widgets/manage_role_widget.dart';
import 'package:student_helper/features/widgets/custom_app_bar.dart';
import 'package:student_helper/features/widgets/custom_bottom_sheet.dart';

import '../../generated/assets.gen.dart';
import '../../generated/locale_keys.g.dart';

class ProfilePage extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileInfoControllerProvider);


    return Scaffold(
      appBar: CAppBar(
        title: Text(
          LocaleKeys.profile_title.tr(),
        ),
      ),
      body: state.when(
          data: (profile) {
            final codeState = ref.watch(getGroupCodeRepositoryProvider(profile.groupId));
            return SingleChildScrollView(
              padding: EdgeInsets.only(left: 17.w, right: 17.w, top: 16.h, bottom: 10.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    profile.name,
                    textAlign: TextAlign.center,
                    style: context.textTheme.header1.copyWith(
                        color: context.colors.accent
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Container(
                    decoration: BoxDecoration(
                        color: context.colors.darkPrimary,
                        borderRadius: BorderRadius.circular(12)
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                      child: Text(
                        getRoleString(profile.role, profile.groupName),
                        style: context.textTheme.header2.copyWith(
                            color: context.colors.accent50
                        ),
                      ),
                    ),
                  ),
                  if (profile.role != UserRole.student)
                    Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: ManageRoleWidget(
                          onAssignCoHeadmanTap: () {
                            CBottomSheet.show(
                                context,
                                child:  GroupParticipantWidget(
                                    title: LocaleKeys.profile_participants.tr(),
                                    onConfirmTap: () {},
                                    groupId: profile.groupId,
                                    isCoHeadman: false
                                )
                            );
                          },
                          onDemoteCoHeadmanTap: () {
                            CBottomSheet.show(context,
                                child:  GroupParticipantWidget(
                                    title: LocaleKeys.profile_co_headmen.tr(),
                                    onConfirmTap: (){},
                                    groupId: profile.groupId,
                                    isCoHeadman: true
                                )
                            );
                          },
                          onRetireTap: () {}
                      ),
                    ),
                  SizedBox(height: 40.h),
                  GroupSettingsWidget(
                      role: profile.role,
                      onValidateScheduleTap: () {},
                      onWatchCodeTap: () {
                        CBottomSheet.show(
                            context,
                            child: Wrap(
                              children: [
                                Builder(
                                  builder: (context) {
                                    if (codeState.hasError) {
                                      return Text("Ошибаешься... \n и вот почему \n ${codeState.error} \n${codeState.stackTrace}");
                                    }
                                    return Center(
                                      child: Container(
                                        width: 200.w,
                                        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
                                        decoration: BoxDecoration(
                                          color: context.colors.accent,
                                          borderRadius: BorderRadius.circular(12)
                                        ),
                                        child: !codeState.hasValue
                                            ? const Center(
                                          child: CircularProgressIndicator())
                                            : Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                    codeState.value ?? "",
                                                    style: context.textTheme.screen.copyWith(
                                                      color: context.colors.primary
                                                    ),
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () async {
                                                  await Clipboard.setData(ClipboardData(text: codeState.value ?? ""));
                                                },
                                                child: SizedBox(
                                                  width: 24.h,
                                                  height: 24.h,
                                                  child: Assets.images.icCopy.svg(),
                                                ),
                                              )
                                            ],
                                        ),
                                      ),
                                    );
                                  }
                                ),
                              ],
                            )
                        );
                      },
                      onKickTap: () {
                        CBottomSheet.show(
                            context,
                            child:  GroupParticipantWidget(
                            title: LocaleKeys.profile_participants.tr(),
                        onConfirmTap: () {},
                        groupId: profile.groupId,
                        isCoHeadman: false
                        ));
                      },
                      onLeaveGroupTap: () {}
                  ),
                  SizedBox(height: 81.h),
                  GestureDetector(
                    onTap: () {
                      ref.read(authRepositoryProvider).logout();
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          LocaleKeys.profile_logout.tr(),
                          style: context.textTheme.header2.copyWith(
                              color: context.colors.shared.white
                          ),
                        ),
                        SizedBox(width: 18.w),
                        SizedBox(
                          width: 24.h,
                          height: 24.h,
                          child: Assets.images.icExit.svg(),
                        )
                      ],
                    ),
                  )

                ],
              ),
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

  String getRoleString(UserRole role, String groupName){
    switch (role){
      case UserRole.headman:
        return LocaleKeys.profile_headman_of.tr(args: [groupName]);
      case UserRole.coHeadman:
        return LocaleKeys.profile_co_headman_of.tr(args: [groupName]);
      default:
        return LocaleKeys.profile_student_of.tr(args: [groupName]);
    }
  }

}