import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:student_helper/common/domain/model/subject_preview/subject_preview.dart';

import '../../../utils/color_types.dart';

part 'subject_info.g.dart';
part 'subject_info.freezed.dart';

@freezed
class HomeworkMini with _$HomeworkMini{
  factory HomeworkMini({
    @JsonKey(name: "homework_id")
    required String homeworkId,
    required String title,
    required DateTime? dadd
}) = _HomeworkMini;

  factory HomeworkMini.fromJson(Map<String, dynamic> json) => _$HomeworkMiniFromJson(json);
}

@freezed
class SubjectInfo with _$SubjectInfo {
  factory SubjectInfo({
    @JsonKey(name: "subject_id")
    required String subjectId,
    required String name,
    @JsonKey(fromJson: SubjectControl.fromJson, toJson: SubjectControl.toJson)
    required SubjectControl control,
    @JsonKey(fromJson: ItemColor.fromJson, toJson: ItemColor.toJson, name: "subject_color")
    required ItemColor color,
    @JsonKey(name: "seminary_teacher")
    required String seminaryTeacher,
    @JsonKey(name: "lecture_teacher")
    required String lectureTeacher,
    required String commentary,
    required List<HomeworkMini> homeworks
}) = _SubjectInfo;

  factory SubjectInfo.fromJson(Map<String, dynamic> json) => _$SubjectInfoFromJson(json);
}